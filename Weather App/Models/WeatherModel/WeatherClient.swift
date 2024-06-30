//
//  WeatherResponse.swift
//  Weather App
//
//  Created by Bugra Aslan on 23.05.2024.
//

import Foundation

// MARK: - WeatherClient
actor WeatherClient {
    private let weatherCache: NSCache<NSString, CacheEntryObject> = NSCache()
    
    private let downloader: any HTTPDataDownloader
    
    private let decoder = JSONDecoder()
    
    var favoriteLocations: [Location]
    
    init(downloader: any HTTPDataDownloader = URLSession.shared, favoriteLocations: [Location]) {
        self.downloader = downloader
        self.favoriteLocations = favoriteLocations
    }
    
    var weatherResponses: [WeatherResponse] {
        get async throws {
            var responses: [WeatherResponse] = []
            
            for location in favoriteLocations {
                responses.append(WeatherResponse(location: location))
            }
            
            try await withThrowingTaskGroup(of: (Int, WeatherResponse).self) { group in
                for (index, location) in favoriteLocations.enumerated() {
                    group.addTask {
                        let response = try await self.locationData(latitude: location.lat ?? 0, longitude: location.lon ?? 0)
                        return (index, response)
                    }
                }
                while let result = await group.nextResult() {
                    switch result {
                    case .failure(let error):
                        throw error
                    case .success(let (index, weatherResponse)):
                        print("success \(index), \(weatherResponse.location?.name ?? "none")")
                        responses[index] = weatherResponse
                    }
                }
            }
            
            return responses
        }
    }
    
    func getData() async throws -> WeatherResponse? {
        do {
            let data = try await downloader.httpData(from: WeatherAPI.url)
            return try decoder.decode(WeatherResponse.self, from: data)
        } catch CustomErrors.HTTPDataDownloaderError(let s, let e) {
            throw CustomErrors.HTTPDataDownloaderError(s, e)
        }
        catch let e as CustomErrors {
            throw e
        } catch {
            throw CustomErrors.WeatherClientError("Couldn't parse data.", error)
        }
    }
    
    func getCurrentLocationData(latitude: Double, longitude: Double) async throws -> WeatherResponse? {
        do {
            let data = try await downloader.httpData(from: WeatherAPI.currentLocationUrl(latitude: latitude, longitude: longitude))
            return try decoder.decode(WeatherResponse.self, from: data)
        } catch CustomErrors.HTTPDataDownloaderError(let s, let e) {
            throw CustomErrors.HTTPDataDownloaderError(s, e)
        }
        catch let e as CustomErrors {
            throw e
        } catch {
            throw CustomErrors.WeatherClientError("Couldn't parse data.", error)
        }
    }
    
    func locationData(latitude: Double, longitude: Double) async throws -> WeatherResponse {
        let url = WeatherAPI.locationUrl(latitude: latitude, longitude: longitude)
        
        if let cached = weatherCache[url] {
            switch cached {
            case .ready(let weatherResponse):
                return weatherResponse
            case .inProgress(let task):
                return try await task.value
            }
        }
        
        let task = Task<WeatherResponse, Error> {
            let data = try await downloader.httpData(from: url)
            let response = try decoder.decode(WeatherResponse.self, from: data)
            return response
        }
        
        weatherCache[url] = .inProgress(task)
        
        do {
            let weatherResponse = try await task.value
            weatherCache[url] = .ready(weatherResponse)
            return weatherResponse
        } catch CustomErrors.HTTPDataDownloaderError(let s, let e) {
            throw CustomErrors.HTTPDataDownloaderError(s, e)
        } catch let e as CustomErrors {
            throw e
        } catch {
            throw CustomErrors.WeatherClientError("Couldn't parse data.", error)
        }
    }
}
