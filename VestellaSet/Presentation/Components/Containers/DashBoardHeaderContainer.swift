//
//  DashBoardHeaderContainer.swift
//  VestellaSet
//
//  Created by 베스텔라랩 on 8/28/25.
//

import SwiftUI
import ComposableArchitecture

struct DashBoardHeaderContainer: View {
    let store: StoreOf<BeaconDashBoardFeature>
    
    var body: some View {
        HStack(spacing: Spacing.s12) {
            DashBoardProgressContainer(store: store)
            Spacer()
            GlassIconButton(image: .importIcon) {
                store.send(.clickImportButton)
            }
            GlassIconButton(image: .settingIcon) {
                store.send(.clickSettingButton)
            }
        }
        .padding(.horizontal, Spacing.s20)
        .padding(.vertical, Spacing.s12)
    }
}
