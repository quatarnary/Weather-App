//
//  MainView+Toolbar.swift
//  Weather App
//
//  Created by Bugra Aslan on 29.06.2024.
//

import SwiftUI

extension MainView {
    
    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            HStack(spacing: 20) {
                Button("??Map View??") {
                    isPresented.toggle()
                }
                .sheet(isPresented: $isPresented, content: {
                    Text("Map Page")
                    Button("Close the sheet") {
                        isPresented.toggle()
                    }
                })
                Spacer()
                HStack {
                    ForEach(0..<favoriteLocations.count + 1, id: \.self) { index in
                        Image(systemName: index == 0 ? "location.fill" : "circle.fill")
                            .resizable()
                            .frame(width: 13, height: 13)
                            .foregroundColor(index == self.selectionTabView ? .accentColor : .white)
                            .onTapGesture {
                                if index < self.selectionTabView {
                                    self.selectionTabView -= 1
                                }
                                if index > self.selectionTabView {
                                    self.selectionTabView += 1
                                }
                            }
                    }
                }
                Spacer()
                NavigationLink("Settings") {
                    MainMenuView()
                }
            }
        }
    }
}
