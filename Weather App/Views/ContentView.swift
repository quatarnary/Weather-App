//
//  ContentView.swift
//  Weather App
//
//  Created by Bugra Aslan on 22.05.2024.
//

import SwiftUI

struct ContentView: View {
    @State var weather: WeatherResponse?
    var weatherClient = WeatherClient()
    @State var status = "Fetching Data.."
    
    var body: some View {
        VStack {
            if weather != nil {
                if weather?.current != nil {
                    if weather?.current?.tempC != nil {
                        Text(String((weather!.current!.tempC!)))
                    } else {
                        Text("There is no weather.current.tempC")
                    }
                } else {
                    Text("There is no weather.current")
                }
            } else {
                ProgressView()
                Text(status)
            }
        }
        .task {
//            try? await Task.sleep(nanoseconds: 3_000_000_000)
            do {
                weather = try await weatherClient.getData()
            } catch {
                status = "\(error.localizedDescription)"
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
