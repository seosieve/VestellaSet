//
//  SettingButton.swift
//  VestellaSet
//
//  Created by 서충원 on 8/15/25.
//

import SwiftUI

struct SettingButton: View {
    @State var value: Int
    
    var body: some View {
        NavigationLink(value: value) {
            Text("Setting")
                .foregroundColor(.blue)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        }
        .padding()
    }
}
