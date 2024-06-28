//
//  MainView.swift
//  Weather App
//
//  Created by Bugra Aslan on 29.05.2024.
//

import SwiftUI
import CoreLocation

struct MainView: View {
    // TODO: take the favoriteLocations from @main and re-arrange the main view accordingly
    // to download all the favotite locations at the same time using different tasks
    // also maybe try to get the current location also @main
    // or maybe even download all the data @main
    // also please for god sake start removing the optional values
    @Binding var favoriteLocations: [Location]
    @State var weather: WeatherResponse?
    @State var currentLocationWeather: WeatherResponse?
    
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    
    @State var selectionTabView: Int = 0
    @State var isPresented = false
    
    var weatherClient = WeatherClient()
    @State var status = "Fetching Data.."
    
    @StateObject var locationManager = UserLocationManager()
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectionTabView) {
                if currentLocationWeather != nil {
                    LocationWeatherDataView(weather: $currentLocationWeather)
                        .tag(0)
                } else {
                    Text("\(status) current location")
                        .tag(0)
                }
                ForEach(Array(favoriteLocations.enumerated()), id: \.element.id) { index, location in
                    LocationWeatherDataView(weather: $weather)
                        .tag(index + 1)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .background(.ultraThinMaterial)
            .background(LinearGradient(colors: [.green, .teal], startPoint: .bottom, endPoint: .top))
            .toolbar(content: toolbarContent)
        }
        .task {
            do {
                // TODO: getData should take list
                weather = try await weatherClient.getData()
            } catch {
                status = "\(error)"
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .inactive { saveAction() }
        }
        .onChange(of: locationManager.userLocation) {
//            print("getting data for user location")
            Task{
                do {
                    currentLocationWeather = try await weatherClient.getCurrentLocationData(latitude: locationManager.userLocation?.latitude ?? 0, longitude: locationManager.userLocation?.longitude ?? 0)
                } catch {
                    status = "\(error)"
                }
            }
        }
    }
}

#Preview {
    var sampleJSONWeatherData = weatherForecastTestData
    var sampleJSONFavoriteData = locationTestData
    var sampleWeatherData: WeatherResponse?
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
    return MainView(favoriteLocations: .constant(favoriteLocations), weather: sampleWeatherData, currentLocationWeather: sampleWeatherData, saveAction: {})
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
