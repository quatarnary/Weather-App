//
//  Condition.swift
//  Weather App
//
//  Created by Bugra Aslan on 24.05.2024.
//

import Foundation

// MARK: - Condition
struct Condition: Codable {
    let text, icon: String?
    let code: Int?
}
