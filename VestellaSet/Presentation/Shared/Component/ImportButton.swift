//
//  ImportButton.swift
//  VestellaSet
//
//  Created by 서충원 on 8/17/25.
//

import SwiftUI
import ComposableArchitecture

struct ImportButton: View {
    let store: StoreOf<BeaconDashBoardFeature>
    
    var body: some View {
        Button {
            store.send(.importButtonTapped)
        } label: {
            Text("Import")
                .foregroundColor(.blue)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        }
    }
}
