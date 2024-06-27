//
//  WeatherResponse.swift
//  Weather App
//
//  Created by Bugra Aslan on 23.05.2024.
//

import Foundation

// MARK: - WeatherClient
struct WeatherClient {
    private let downloader: any HTTPDataDownloader
    
    private let decoder = JSONDecoder()
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
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
}
