//
//  HourlyForecast.swift
//  Weather App
//
//  Created by Bugra Aslan on 27.05.2024.
//

import SwiftUI

struct HourlyForecastView: View {
    @State var weather: WeatherResponse?
    //    @State var time: String?
    var dateFormatter: DateFormatter {
        let dummyFormatter = DateFormatter()
        dummyFormatter.dateFormat = "yyyy-mm-dd hh:mm"
        return dummyFormatter
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Label("Hourly Forecast", systemImage: "clock.badge.questionmark")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach((weather?.forecast?.forecastday?[0].hour)!) { hour in
                        let time = Date(timeIntervalSince1970: TimeInterval(hour.timeEpoch!)).formatted(date: .omitted, time: .shortened)
                        
                        VStack {
                            Text(time)
                            Image(systemName: "sun.min")
                            Text(String(hour.tempC ?? -999) + "°")
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
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
    return HourlyForecastView(weather: sampleWeatherData)
}
