//
//  BeaconSettingView.swift
//  VestellaSet
//
//  Created by 서충원 on 1/20/25.
//

import SwiftUI
import ComposableArchitecture

struct BeaconSettingView: View {
    let store: StoreOf<BeaconSettingFeature>
    
    var body: some View {
        
        VStack {
            BackButton {
                store.send(.clickBackButton)
            }
            Spacer()
            TextFieldContainer()
            TextFieldContainer()
            TextFieldContainer()
            Spacer()
        }
        .monoBackground()
        .navigationBarBackButtonHidden()
    }
}
