//
//  MainView.swift
//  Weather App
//
//  Created by Bugra Aslan on 29.05.2024.
//

import SwiftUI
import CoreLocation

struct MainView: View {
    // TODO: maybe try to get the current location also @main
    // or maybe even download all the data @main
    // also please for god sake start removing the optional values
    @Binding var favoriteLocations: [Location]
    @State var currentLocationWeather: WeatherResponse = WeatherResponse()
    
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    
    @State var selectionTabView: Int = 0
    @State var isPresented = false
    
    var weatherClient: WeatherClient {
        WeatherClient(favoriteLocations: favoriteLocations)
    }
    @State var favoriteLocationWeatherResponses: [WeatherResponse] = []
    
    @State var status = "Fetching Data.."
    
    @StateObject var locationManager = UserLocationManager()
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectionTabView) {
                if currentLocationWeather.location != nil {
                    LocationWeatherDataView(weather: $currentLocationWeather)
                        .tag(0)
                } else {
                    Text("\(status) current location")
                        .tag(0)
                }
                if !favoriteLocationWeatherResponses.isEmpty {
                    ForEach(Array(zip(favoriteLocationWeatherResponses.indices, favoriteLocationWeatherResponses)), id: \.0) { index, item in
                        LocationWeatherDataView(weather: $favoriteLocationWeatherResponses[index])
                            .tag(index + 1)
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .background(.ultraThinMaterial)
            .background(LinearGradient(colors: [.green, .teal], startPoint: .bottom, endPoint: .top))
            .toolbar(content: toolbarContent)
        }
        .onChange(of: favoriteLocations.count) {
            Task {
                do {
                    favoriteLocationWeatherResponses = try await weatherClient.weatherResponses
                } catch {
                    print("\(error)")
                }
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .inactive { saveAction() }
        }
        .onChange(of: locationManager.userLocation) {
            Task {
                do {
                    currentLocationWeather = try await weatherClient.getCurrentLocationData(
                        latitude: locationManager.userLocation?.latitude ?? 0,
                        longitude: locationManager.userLocation?.longitude ?? 0
                    )!
                } catch {
                    print("\(error)")
                }
            }
        }
    }
}

#Preview {
    var sampleJSONWeatherData = weatherForecastTestData
    var sampleJSONFavoriteData = locationTestData
    var sampleWeatherData = WeatherResponse()
    var favoriteLocations: [Location] = []
    
    do {
        sampleWeatherData = try JSONDecoder().decode(WeatherResponse.self, from: sampleJSONWeatherData)
    } catch {
        print("weather data error")
        print(error)
    }
    do {
        favoriteLocations = try JSONDecoder().decode([Location].self, from: sampleJSONFavoriteData)
    } catch {
        print("locations error")
        print(error)
    }
    return MainView(favoriteLocations: .constant(favoriteLocations), currentLocationWeather: sampleWeatherData, saveAction: {})
}



/*
 
 do {
 let location = locationManager.userLocation
 let latitude = location?.latitude ?? 0
 let longitude = location?.longitude ?? 0
 currentLocationWeather = try await weatherClient.getCurrentLocationData(latitude: latitude, longitude: longitude)
 } catch {
 status = "current location error: \(error)"
 }
 
 */
