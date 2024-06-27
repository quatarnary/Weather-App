//
//  SettingsView.swift
//  Weather App
//
//  Created by Bugra Aslan on 30.05.2024.
//

import SwiftUI

struct SettingsView: View {
    @State var selection: Int
    @Binding var isNotificationsPresented: Bool
    @Binding var isUnitsPresented: Bool
    @Binding var isReportIssuePresented: Bool
    @Binding var editMode: EditMode
    
    var body: some View {
//        EditButton()
        Button(editMode == .inactive ? "Edit Button" : "Finish Editing") {
            if editMode == .inactive {
                editMode = .active
            } else if editMode == .active {
                editMode = .inactive
            }
        }
        Button("Notifications") {
            isNotificationsPresented.toggle()
        }
        
        Picker("", selection: $selection) {
            Label("Celsius", systemImage: "c.square")
                .tag(0)
            Label("Fahrenheit", systemImage: "f.square")
                .tag(1)
        }
        .pickerStyle(.inline)
        
        Button("Units") {
            isUnitsPresented.toggle()
        }
        Button("Report an Issue") {
            isReportIssuePresented.toggle()
        }
    }
}

#Preview {
    @State var selection: Int = 0
    @State var isPresented: Bool = false
    @State var isUnitsPresented: Bool = false
    @State var isReportIssuePresented: Bool = false
    @State var editMode: EditMode = .inactive
    return SettingsView(selection: selection, isNotificationsPresented: $isPresented, isUnitsPresented: $isUnitsPresented, isReportIssuePresented: $isReportIssuePresented, editMode: $editMode)
}
