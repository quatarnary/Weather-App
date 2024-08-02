//
//  WeatherSummary.swift
//  Weather App
//
//  Created by Bugra Aslan on 27.05.2024.
//

import SwiftUI

struct WeatherSummaryView: View {
    @Binding var weather: WeatherResponse
    var body: some View {
        VStack {
            Text(weather.location?.name ?? "No Data")
                .font(.title)
            
            Text(String(weather.current?.tempC ?? -999) + "°")
                .font(.largeTitle)
            
            Text(weather.current?.condition?.text ?? "No Data")
            
            HStack {
                Text("H: " + String(weather.forecast?.forecastday?[0].day?.maxtempC ?? -999) + "°")
                Text("L: " + String(weather.forecast?.forecastday?[0].day?.mintempC ?? -999) + "°")
            }
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
    return WeatherSummaryView(weather: .constant(sampleWeatherData))
}
