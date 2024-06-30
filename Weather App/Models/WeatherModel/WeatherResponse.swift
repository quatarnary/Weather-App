//
//  WeatherResponse.swift
//  Weather App
//
//  Created by Bugra Aslan on 24.05.2024.
//

import Foundation

// MARK: - WeatherResponse
struct WeatherResponse: Codable {
    var location: Location?
    var current: Current?
    var forecast: Forecast?
}

extension WeatherResponse: Identifiable {
    var id: UUID { UUID() }
}
