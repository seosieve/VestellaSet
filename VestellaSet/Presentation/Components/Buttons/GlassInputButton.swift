//
//  GlassInputButton.swift
//  VestellaSet
//
//  Created by 베스텔라랩 on 8/26/25.
//

import SwiftUI

struct GlassInputButton: View {
    let type: SettingInfoType
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(type.title)
                    .foregroundStyle(Color.monoBase)
                    .font(Manrope.regular(size: 15))
                Spacer()
                Text(type.value)
                    .font(Manrope.regular(size: 15))
                    
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, maxHeight: 52)
            .glassActionButtonStyle()
            .padding(.horizontal, Spacing.s20)
        }
        .buttonStyle(BouncyButtonStyle(scalePercent: 101))
    }
}
