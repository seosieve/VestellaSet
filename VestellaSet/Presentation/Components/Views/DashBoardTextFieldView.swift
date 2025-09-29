//
//  DashBoardTextFieldView.swift
//  VestellaSet
//
//  Created by 베스텔라랩 on 8/28/25.
//

import SwiftUI
import ComposableArchitecture

struct DashBoardTextFieldView: View {
    let store: StoreOf<BeaconDashBoardFeature>
    
    @FocusState.Binding var isFocused: Bool
    
    @State private var text: String = ""
    
    var body: some View {
        HStack(spacing: Spacing.s8) {
            Image.searchIcon
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.monoDark)
            
            TextField("", text: $text, prompt: Text.keywordPlaceholder)
                .frame(height: 44)
                .tint(.mintBase)
                .autocorrectionDisabled()
                .disableAutocorrection(true)
                .focused($isFocused)
        }
        .padding(.horizontal, Spacing.s16)
        .background(Color.monoShadow)
        .cornerRadius(Radius.s8)
        .padding(.horizontal, Spacing.s20)
    }
}
