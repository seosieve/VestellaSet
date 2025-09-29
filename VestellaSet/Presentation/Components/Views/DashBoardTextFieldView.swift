//
//  DashBoardTextFieldView.swift
//  VestellaSet
//
//  Created by 베스텔라랩 on 8/28/25.
//

import SwiftUI
import ComposableArchitecture

struct DashBoardTextFieldView: View {
    @Bindable var store: StoreOf<BeaconDashBoardFeature>
    @FocusState.Binding var isFocused: Bool
    
    var body: some View {
        HStack(spacing: Spacing.s8) {
            Image.searchIcon
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.monoDark)
            
            TextField("", text: $store.keyword, prompt: Text.keywordPlaceholder)
                .frame(height: 44)
                .tint(.mintBase)
                .autocorrectionDisabled()
                .keyboardType(.asciiCapable)
                .focused($isFocused)
        }
        .padding(.horizontal, Spacing.s16)
        .background(Color.monoShadow)
        .cornerRadius(Radius.s8)
        .padding(.horizontal, Spacing.s20)
    }
}
