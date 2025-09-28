//
//  SaveSettingButton.swift
//  VestellaSet
//
//  Created by 서충원 on 9/28/25.
//

import SwiftUI
import ComposableArchitecture

struct SaveSettingButton: View {
    let store: StoreOf<BeaconSettingFeature>
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(ActionInfoType.save.title)
                .font(Manrope.bold(size: 17))
                .foregroundStyle(store.isSaveEnabled ? Color.mintBlack: Color.mintShadow)
                .padding(.vertical, Spacing.s12)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(height: 56)
        .background(store.isSaveEnabled ? Color.mintBase: Color.mintDark)
        .cornerRadius(Radius.s8)
        .padding(.horizontal, Spacing.s20)
        .padding(.top, Spacing.s12)
        .padding(.bottom, Spacing.s8)
        .disabled(!store.isSaveEnabled)
        .animation(.easeInOut, value: store.isSaveEnabled)
    }
}
