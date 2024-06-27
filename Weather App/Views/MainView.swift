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
    
    @ObservedObject var locationManager = UserLocationManager()
    
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
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack(spacing: 20) {
                        Button("??Map View??") {
                            isPresented.toggle()
                        }
                        .sheet(isPresented: $isPresented, content: {
                            Text("Map Page")
                            Button("Close the sheet") {
                                isPresented.toggle()
                            }
                        })
                        Spacer()
                        HStack {
                            ForEach(0..<favoriteLocations.count + 1, id: \.self) { index in
                                Image(systemName: index == 0 ? "location.fill" : "circle.fill")
                                    .resizable()
                                    .frame(width: 13, height: 13)
                                    .foregroundColor(index == self.selectionTabView ? .accentColor : .white)
                                    .onTapGesture {
                                        if index < self.selectionTabView {
                                            self.selectionTabView -= 1
                                        }
                                        if index > self.selectionTabView {
                                            self.selectionTabView += 1
                                        }
                                    }
                            }
                        }
                        Spacer()
                        NavigationLink("Settings") {
                            MainMenuView()
                        }
                    }
                }
            }
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
