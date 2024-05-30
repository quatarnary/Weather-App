//
//  MainMenuView.swift
//  Weather App
//
//  Created by Bugra Aslan on 30.05.2024.
//

import SwiftUI

struct MainMenuView: View {
    @State var searchText: String = ""
    let favoriteLocationCount: Int = 3
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Weather")
                    .font(.largeTitle)
                TextField("abc", text: $searchText)
                // swift cries because we don't have id here, it can be solved as putting id: \.self, however the model for favorite locations will have the id variable as UUID so it will be solved when the time comes
                ForEach(0..<favoriteLocationCount) { card in
                    LocationCardView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink("Settings") {
                        Text("abc")
                    }
                }
            }
        }
    }
}

#Preview {
    MainMenuView()
}
