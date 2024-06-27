//
//  LocationCardView.swift
//  Weather App
//
//  Created by Bugra Aslan on 30.05.2024.
//

import SwiftUI

struct LocationCardView: View {
    var body: some View {
        HStack {
            VStack {
                Text("Location Name")
                Text("Time")
                Spacer()
                Text("Condition")
            }
            Spacer()
            VStack {
                Text("Current Degree°")
                Spacer()
                HStack {
                    Text("H: degree°")
                    Text("L: degree°")
                }
            }
        }
        .frame(height: 100)
        .padding(4)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
    }
}

#Preview {
    LocationCardView()
}
