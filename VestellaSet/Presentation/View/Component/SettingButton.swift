//
//  SettingButton.swift
//  VestellaSet
//
//  Created by 서충원 on 8/15/25.
//

import SwiftUI

struct SettingButton: View {
    var body: some View {
        NavigationLink(value: Destination.setting) {
            Text("Setting")
                .foregroundColor(.blue)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        }
        .padding()
    }
}
