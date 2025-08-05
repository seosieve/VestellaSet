//
//  BeaconSettingView.swift
//  BeaconSet
//
//  Created by 서충원 on 1/20/25.
//

import SwiftUI

internal struct BeaconSettingView: View {
    @State internal var text: String = ""
    
    internal var body: some View {
        VStack {
            TextField("Enter your text", text: $text)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
        }
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
