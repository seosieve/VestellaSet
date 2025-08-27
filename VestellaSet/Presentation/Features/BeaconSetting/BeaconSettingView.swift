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
                GlassSelectionButton(type: .interval(3), action: { store.send(.showSheet(.interval)) })
                GlassSelectionButton(type: .power(4), action: { store.send(.showSheet(.power)) })
                ActionButton(type: .save) { store.send(.clickBackButton) }
                Spacer()
            }
            .blur(radius: store.isSheetPresented ? 8 : 0)
            .animation(.easeOut, value: store.isSheetPresented)
            
            SettingSheetContainer(store: store)
        }
        .monoBackground()
        .navigationBarBackButtonHidden()
    }
}
