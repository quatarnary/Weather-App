//
//  MainMenuView.swift
//  Weather App
//
//  Created by Bugra Aslan on 30.05.2024.
//

import SwiftUI

struct MainMenuView: View {
    @State var searchText: String = ""
    @State var favoriteLocations = [
        "Istanbul",
        "Ankara",
        "London"
    ]
    @State var favoriteBackUp: [Int:String] = [:]
    @State var selection: Int = 0
    @State var isNotificationsPresented: Bool = false
    @State var isUnitsPresented: Bool = false
    @State var isReportIssuePresented: Bool = false
    @State var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Weather")
                    .font(.largeTitle)
                TextField("abc", text: $searchText)
                // swift cries because we don't have id here, it can be solved as putting id: \.self, however the model for favorite locations will have the id variable as UUID so it will be solved when the time comes
                List {
                    Text("Current Location")
                    ForEach(favoriteLocations, id: \.self) { location in
    //                    LocationCardView()
                        Text("\(location)")
                    }
                    .onDelete { indexSet in
                        indexSet.forEach({favoriteBackUp[$0] = favoriteLocations[$0]})
                            favoriteLocations.remove(atOffsets: indexSet)
                    }
                    .onMove {
                        favoriteLocations.move(fromOffsets: $0, toOffset: $1)
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Edit") {
                        editMode = .active
                    }
                }
                ToolbarItemGroup(placement: .topBarLeading) {
                    if editMode == .active {
                        Button("Cancel", role: .cancel) {
                            favoriteBackUp.forEach({i, s in favoriteLocations.insert(s, at: i)})
                            favoriteBackUp.removeAll()
                            editMode = .inactive
                        }
                    } else {
                        Menu {
                            SettingsView(selection: selection, isNotificationsPresented: $isNotificationsPresented, isUnitsPresented: $isUnitsPresented, isReportIssuePresented: $isReportIssuePresented, editMode: $editMode)
                        } label: {
                            Label("Filter", systemImage: "slider.horizontal.3")
                        }
                        .sheet(isPresented: $isNotificationsPresented) {
                            Text("Notifications View")
                            Image(systemName: "pencil")
                        }
                        .sheet(isPresented: $isUnitsPresented) {
                            Text("Units View")
                            Image(systemName: "pencil")
                        }
                        .sheet(isPresented: $isReportIssuePresented) {
                            Text("Report an Issue View")
                            Image(systemName: "pencil")
                        }
                    }
                }
            }
            .environment(\.editMode, $editMode)
            Spacer()
        }
    }
}

#Preview {
    MainMenuView()
}
