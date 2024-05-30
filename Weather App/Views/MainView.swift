//
//  MainView.swift
//  Weather App
//
//  Created by Bugra Aslan on 29.05.2024.
//

import SwiftUI

struct MainView: View {
    @State var weather: WeatherResponse?
    @State var selectionTabView: Int = 1
    @State var isPresented = false
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectionTabView) {
                Text("Current Location Page")
                    .tag(0)
                LocationWeatherDataView(weather: weather)
                    .tag(1)
                Text("My Locations 2nd Item Page")
                    .tag(2)
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
