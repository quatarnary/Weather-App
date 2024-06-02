//
//  MainView.swift
//  Weather App
//
//  Created by Bugra Aslan on 29.05.2024.
//

import SwiftUI
import CoreLocation

struct MainView: View {
    @State var weather: WeatherResponse?
    @State var currentLocationWeather: WeatherResponse?
    
    @State var selectionTabView: Int = 0
    @State var isPresented = false
    
    var weatherClient = WeatherClient()
    @State var status = "Fetching Data.."
    
    @ObservedObject var locationManager = UserLocationManager()
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectionTabView) {
                if currentLocationWeather != nil && weather != nil {
                    LocationWeatherDataView(weather: $currentLocationWeather)
                        .tag(0)
                    LocationWeatherDataView(weather: $weather)
                        .tag(1)
                    Text("My Locations 2nd Item Page")
                        .tag(2)
                } else if weather != nil {
                    List {
                        Text("NO DATA FOR CURRENT LOCATION")
                            .tag(0)
                    }
                    .refreshable() {
                        do {
                            let location = locationManager.userLocation
                            let latitude = location?.latitude ?? 0
                            let longitude = location?.longitude ?? 0
                            currentLocationWeather = try await weatherClient.getCurrentLocationData(latitude: latitude, longitude: longitude)
                        } catch {
                            status = "current location error: \(error)"
                        }
                    }
                    LocationWeatherDataView(weather: $weather)
                        .tag(1)
                    Text("My Locations 2nd Item Page")
                        .tag(2)
                } else {
                    Text("\(status)")
                        .tag(0)
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
                            ForEach(0..<3) { index in
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
            //            try? await Task.sleep(nanoseconds: 3_000_000_000)
            do {
                weather = try await weatherClient.getData()
            } catch {
                status = "\(error)"
            }
            //            do {
            //                let location = locationManager.userLocation
            //                let latitude = location?.latitude ?? 0
            //                let longitude = location?.longitude ?? 0
            //                currentLocationWeather = try await weatherClient.getCurrentLocationData(latitude: latitude, longitude: longitude)
            //            } catch {
            //                status = "current location error: \(error)"
            //            }
        }
    }
}

#Preview {
    var sampleJSONWeatherData = weatherForecastTestData
    var sampleWeatherData: WeatherResponse?
    do {
        sampleWeatherData = try JSONDecoder().decode(WeatherResponse.self, from: sampleJSONWeatherData)
    } catch {
        print(error)
    }
    return MainView(weather: sampleWeatherData)
}
