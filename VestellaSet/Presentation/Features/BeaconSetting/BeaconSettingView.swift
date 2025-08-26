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
        ZStack {
            VStack(spacing: Spacing.s12) {
                BackButton { store.send(.clickBackButton) }
                SettingTitleLabel()
                GlassInputButton(type: .uuid(Vestella.uuid), action: {})
                GlassPickerButton(type: .interval(3), action: { store.send(.startPicking(.interval)) })
                GlassPickerButton(type: .power(4), action: { store.send(.startPicking(.power)) })
                ActionButton(type: .save) { store.send(.clickBackButton) }
                Spacer()
            }
            .blur(radius: store.isPicking ? 8 : 0)
            .animation(.easeOut, value: store.isPicking)
            
            SettingPickerContainer(store: store)
        }
        .monoBackground()
        .navigationBarBackButtonHidden()
    }
}
