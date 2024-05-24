//
//  WeatherResponse.swift
//  Weather App
//
//  Created by Bugra Aslan on 24.05.2024.
//

import Foundation

// MARK: - WeatherResponse
struct WeatherResponse: Codable {
    let location: Location?
    let current: Current?
    let forecast: Forecast?
}
