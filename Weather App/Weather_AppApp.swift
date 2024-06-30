//
//  Weather_AppApp.swift
//  Weather App
//
//  Created by Bugra Aslan on 22.05.2024.
//

import SwiftUI

@main
struct Weather_AppApp: App {
    @StateObject private var store = UserFavoriteLocations()
    
    var body: some Scene {
        WindowGroup {
            MainView(favoriteLocations: $store.favoriteLocations) {
                Task {
                    do {
                        try await store.save(locations: store.favoriteLocations)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .task {
                do {
                    try await store.load()
#if DEBUG
                    if store.favoriteLocations.isEmpty {
                        do {
                            store.favoriteLocations = try JSONDecoder().decode([Location].self, from: locationTestData)
                        } catch {
                            print("locations error")
                            print(error)
                        }
                    }
#endif
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
}
