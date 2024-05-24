//
//  API_KEY_MANAGER.swift
//  Weather App
//
//  Created by Bugra Aslan on 23.05.2024.
//

import Foundation

// MARK: - APIKEY
struct WeatherAPI {
    static var keyURL = Bundle.main.url(forResource: "API-Keys", withExtension: "plist")

    static let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=\(getKey())&q=istanbul&days=1&aqi=yes&alerts=no")!
    
    static func getKey() -> String {
        return NSDictionary(contentsOf: keyURL!)!["WEATHER_API_KEY"] as! String
    }
}
