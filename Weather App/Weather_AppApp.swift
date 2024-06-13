//
//  Weather_AppApp.swift
//  Weather App
//
//  Created by Bugra Aslan on 22.05.2024.
//

import SwiftUI

@main
struct Weather_AppApp: App {
    @StateObject private var favoriteLocations = UserFavoriteLocations()
    @State var dummyFavoriteLocations: [Location] = []
    
    var body: some Scene {
        WindowGroup {
            MainView(favoriteLocations: $dummyFavoriteLocations)
                .task {
                    do {
                        try await favoriteLocations.load()
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
        }
    }
}
