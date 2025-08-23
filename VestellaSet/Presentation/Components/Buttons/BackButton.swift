//
//  BackButton.swift
//  VestellaSet
//
//  Created by 서충원 on 8/21/25.
//

import SwiftUI
import ComposableArchitecture

struct BackButton: View {
    let store: StoreOf<BeaconImportFeature>
    
    var body: some View {
        HStack {
            GlassButton(imageName: "XMark") {
                store.send(.clickBackButton)
            }
            Spacer()
        }
        .padding(.top, 12)
        .padding(.leading, 20)
    }
}

