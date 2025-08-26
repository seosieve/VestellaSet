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
        VStack(spacing: Spacing.s24) {
            BackButton { store.send(.clickBackButton) }
            TitleLabel("Setting")
            VStack(spacing: Spacing.s12) {
                GlassInputButton(type: .uuid(Vestella.uuid), action: {})
                GlassPickerButton(type: .interval(3), action: {})
                GlassPickerButton(type: .power(4), action: {})
            }
            ActionButton("Save") { store.send(.clickSaveButton) }
            Spacer()
        }
        .monoBackground()
        .navigationBarBackButtonHidden()
    }
}
