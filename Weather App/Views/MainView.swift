//
//  MainView.swift
//  Weather App
//
//  Created by Bugra Aslan on 29.05.2024.
//

import SwiftUI

struct MainView: View {
    @State var weather: WeatherResponse?
    
    var body: some View {
        TabView {
            LocationWeatherDataView(weather: weather)
                .badge(1)
                .tabItem {
                    Label("Current Location", systemImage: "tray.and.arrow.down.fill")
                }
            Text("My Locations Page")
                .badge("!")
                .tabItem {
                    Label("Locations", systemImage: "tray.and.arrow.up.fill")
                }
            Text("Settings Page")
                .badge("!")
                .tabItem {
                    Label("Settings", systemImage: "person.crop.circle.fill")
                }
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
