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
    
    @State private var text: String = ""
    var placeholder: String = "Search by UUID, Major, or Minor"
    
    var body: some View {
        HStack(spacing: Spacing.s8) {
            Image.searchIcon
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.monoMedium)
            
            TextField(placeholder, text: $text)
                .frame(height: 44)
                .tint(.mintBase)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
        .padding(.horizontal, Spacing.s16)
        .background(Color.monoShadow)
        .cornerRadius(Radius.s8)
        .padding(.horizontal, Spacing.s20)
    }
}
