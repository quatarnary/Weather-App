//
//  ContentView.swift
//  Weather App
//
//  Created by Bugra Aslan on 22.05.2024.
//

import SwiftUI

struct LocationWeatherDataView: View {
    @State var weather: WeatherResponse?
    var weatherClient = WeatherClient()
    @State var status = "Fetching Data.."
    
    var body: some View {
        VStack {
            Spacer()
            WeatherSummaryView(weather: weather)
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.ultraThinMaterial)
                .padding(.horizontal)
            Spacer()
            HourlyForecastView(weather: weather)
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.ultraThinMaterial)
                .padding(.horizontal)
            Spacer()
            DailyForecastView(weather: weather)
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.ultraThinMaterial)
                .padding(.horizontal)
            Spacer()
        }
        .background(.ultraThinMaterial)
        .background(LinearGradient(colors: [.green, .teal], startPoint: .bottom, endPoint: .top))
    }
}

#Preview {
    var sampleJSONWeatherData = weatherForecastTestData
    do {
        var sampleWeatherData = try JSONDecoder().decode(WeatherResponse.self, from: sampleJSONWeatherData)
        return LocationWeatherDataView(weather: sampleWeatherData)
    } catch {
        print(error)
        return LocationWeatherDataView()
    }
}


/*
 VStack {
 if weather != nil {
 
 } else {
 ProgressView()
 Text(status)
 }
 }
 //        .task {
 ////            try? await Task.sleep(nanoseconds: 3_000_000_000)
 //            do {
 //                weather = try await weatherClient.getData()
 //            } catch {
 //                status = "\(error.localizedDescription)"
 //            }
 //        }
 .padding()
 */
