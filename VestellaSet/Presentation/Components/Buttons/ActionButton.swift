//
//  ActionButton.swift
//  VestellaSet
//
//  Created by 서충원 on 8/19/25.
//

import SwiftUI
import ComposableArchitecture

struct ActionButton: View {
    var type: ActionInfoType
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(type.title)
                .font(Manrope.bold(size: 17))
                .foregroundColor(.mintBlack)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(height: 56)
        .background(Color.mintBase)
        .cornerRadius(8)
        .padding(.horizontal, Spacing.s20)
        .padding(.top, Spacing.s12)
        .padding(.bottom, Spacing.s8)
    }
}
