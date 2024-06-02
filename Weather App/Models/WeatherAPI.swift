//
//  API_KEY_MANAGER.swift
//  Weather App
//
//  Created by Bugra Aslan on 23.05.2024.
//

import Foundation

// MARK: - APIKEY
struct WeatherAPI {
    
    #if DEBUG
    static var keyURL = Bundle.main.url(forResource: "local", withExtension: "plist")
    #else
    static var keyURL = Bundle.main.url(forResource: "API-Keys", withExtension: "plist")
    #endif

    static let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=\(getKey())&q=istanbul&days=3&aqi=yes&alerts=no")!
    
    static func getKey() -> String {
        return NSDictionary(contentsOf: keyURL!)!["WEATHER_API_KEY"] as! String
    }
}


/*
 static let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=\(getKey("WEATHER_API_KEY"))&q=istanbul&days=3&aqi=yes&alerts=no")!
 
 static func getKey(_ keyName: String) -> String {
 return NSDictionary(contentsOf: keyURL!)![keyName] as! String
 }
 */
