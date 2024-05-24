//
//  CustomNetworkErrors.swift
//  Weather App
//
//  Created by Bugra Aslan on 24.05.2024.
//

import Foundation

enum CustomErrors: Error {
    case HTTPDataDownloaderError(String, Error? = nil)
    case WeatherClientError(String, Error? = nil)
}
