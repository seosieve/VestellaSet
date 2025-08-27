//
//  GlassSelectionButton.swift
//  VestellaSet
//
//  Created by 서충원 on 8/25/25.
//

import SwiftUI

struct GlassSelectionButton: View {
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
                    .font(Manrope.bold(size: 17))
                Image.chevronDownIcon
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(Color.monoMedium)
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, maxHeight: 52)
            .glassActionButtonStyle()
            .padding(.horizontal, Spacing.s20)
        }
        .buttonStyle(BouncyButtonStyle(scalePercent: 101))
    }
}
