//
//  CacheEntryObject.swift
//  Weather App
//
//  Created by Bugra Aslan on 29.06.2024.
//

import Foundation

final class CacheEntryObject {
    let entry: CacheEntry
    init(entry: CacheEntry) { self.entry = entry }
}


enum CacheEntry {
    case inProgress(Task<WeatherResponse, Error>)
    case ready(WeatherResponse)
}
