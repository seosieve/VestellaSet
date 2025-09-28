//
//  SaveQRButton.swift
//  VestellaSet
//
//  Created by 서충원 on 9/28/25.
//

import SwiftUI
import ComposableArchitecture

struct SaveQRButton: View {
    let store: StoreOf<BeaconImportFeature>
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(ActionInfoType.save.title)
                .font(Manrope.bold(size: 17))
                .foregroundStyle(Color.mintBlack)
                .padding(.vertical, Spacing.s12)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(height: 56)
        .background(Color.mintBase)
        .cornerRadius(Radius.s8)
        .padding(.horizontal, Spacing.s20)
        .padding(.top, Spacing.s12)
        .padding(.bottom, Spacing.s8)
        .opacity(store.isFinished ? 1 : 0)
        .animation(.easeInOut, value: store.isFinished)
    }
}
