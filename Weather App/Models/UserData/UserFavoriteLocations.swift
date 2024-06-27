//
//  UserFavoriteLocations.swift
//  Weather App
//
//  Created by Bugra Aslan on 3.06.2024.
//

import SwiftUI

@MainActor
class UserFavoriteLocations: ObservableObject {
    @Published var favoriteLocations: [Location] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("FavoriteLocations.data")
    }
    
    func load() async throws {
        let task = Task<[Location], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let userFavoriteLocations = try JSONDecoder().decode([Location].self, from: data)
            return userFavoriteLocations
        }
        let locations = try await task.value
        self.favoriteLocations = locations
    }
    
    func save(locations: [Location]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(locations)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        
        _ = try await task.value
    }
}
