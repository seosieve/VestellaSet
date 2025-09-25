//
//  GlassTextField.swift
//  VestellaSet
//
//  Created by 베스텔라랩 on 8/26/25.
//

import SwiftUI
import ComposableArchitecture

struct GlassTextField: View {
    @Bindable var store: StoreOf<BeaconSettingFeature>
    @FocusState.Binding var isFocused: Bool
    
    var body: some View {
        HStack(spacing: Spacing.s24) {
            Text(SettingInfoType.uuid.title)
                .foregroundStyle(Color.monoBase)
                .font(Manrope.regular(size: 15))
            TextField("", text: $store.uuid, prompt: Text.uuidPlaceholder)
                .tint(.mintBase)
                .font(Manrope.bold(size: 16))
                .multilineTextAlignment(.trailing)
                .focused($isFocused)
        }
        .padding(.horizontal, Spacing.s16)
        .frame(maxWidth: .infinity, maxHeight: 52)
        .glassActionButtonStyle()
        .padding(.horizontal, Spacing.s20)
    }
}
