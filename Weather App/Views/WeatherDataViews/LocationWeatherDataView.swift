//
//  ContentView.swift
//  Weather App
//
//  Created by Bugra Aslan on 22.05.2024.
//

import SwiftUI

struct LocationWeatherDataView: View {
    @Binding var weather: WeatherResponse
    @State var status = "Fetching Data.."
    
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
    var sampleJSONWeatherData = weatherForecastTestData
    var sampleWeatherData = WeatherResponse()
    do {
        sampleWeatherData = try JSONDecoder().decode(WeatherResponse.self, from: sampleJSONWeatherData)
    } catch {
        print(error)
    }
    return LocationWeatherDataView(weather: .constant(sampleWeatherData))
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
