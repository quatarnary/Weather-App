//
//  DailyForecast.swift
//  Weather App
//
//  Created by Bugra Aslan on 27.05.2024.
//

import SwiftUI

struct DailyForecastView: View {
    @Binding var weather: WeatherResponse?
    private var forecastDayCount: Int {
        weather?.forecast?.forecastday?.count ?? -999
    }
    private var dateFormatter: DateFormatter {
        let dummyFormatter = DateFormatter()
        dummyFormatter.dateFormat = "EEEE"
        return dummyFormatter
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(forecastDayCount) day forecast")
            ForEach((weather?.forecast?.forecastday)!) { forecastday in
                let day = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(forecastday.dateEpoch!)))
                let today = dateFormatter.string(from: Date())
                HStack {
                    Text("\(day == today ? "Today" : day)")
                        .frame(minWidth: 100, alignment: .leading)
                    Spacer()
                    Image(systemName: "sun.min")
                    Spacer()
                    Text("L: \(forecastday.day?.mintempC ?? -999, specifier: "%.1f")°")
                    Spacer()
                    Text("H: \(forecastday.day?.maxtempC ?? -999, specifier: "%.1f")°")
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    var sampleJSONWeatherData = weatherForecastTestData
    @State var sampleWeatherData: WeatherResponse?
    do {
        sampleWeatherData = try JSONDecoder().decode(WeatherResponse.self, from: sampleJSONWeatherData)
    } catch {
        print(error)
    }
    return DailyForecastView(weather: $sampleWeatherData)
}
