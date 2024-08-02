//
//  ContentView.swift
//  Weather App
//
//  Created by Bugra Aslan on 22.05.2024.
//

import SwiftUI

struct LocationWeatherDataView: View {
    @Binding var weather: WeatherResponse
    
    var body: some View {
        VStack {
            Spacer()
            WeatherSummaryView(weather: $weather)
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.ultraThinMaterial)
                .padding(.horizontal)
            Spacer()
            HourlyForecastView(weather: $weather)
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.ultraThinMaterial)
                .padding(.horizontal)
            Spacer()
            DailyForecastView(weather: $weather)
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.ultraThinMaterial)
                .padding(.horizontal)
            Spacer()
        }
    }
}

#Preview {
    let sampleJSONWeatherData = weatherForecastTestData
    var sampleWeatherData = WeatherResponse()
    do {
        sampleWeatherData = try JSONDecoder().decode(WeatherResponse.self, from: sampleJSONWeatherData)
    } catch {
        print(error)
    }
    return LocationWeatherDataView(weather: .constant(sampleWeatherData))
}
