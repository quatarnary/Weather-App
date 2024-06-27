//
//  Location.swift
//  Weather App
//
//  Created by Bugra Aslan on 24.05.2024.
//

import Foundation

struct Location: Codable {
    let name, region, country: String?
    let lat, lon: Double?
    let tzID: String?
    let localtimeEpoch: Int?
    let localtime: String?
    
    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}

extension Location: Identifiable {
    var id: UUID { UUID() }
}
