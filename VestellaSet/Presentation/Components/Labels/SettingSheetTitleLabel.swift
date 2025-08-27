//
//  SettingSheetTitleLabel.swift
//  VestellaSet
//
//  Created by 서충원 on 8/27/25.
//

import SwiftUI

struct SettingSheetTitleLabel: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(Color.monoWhite)
                .font(Manrope.extraBold(size: 18))
                .padding(.horizontal, Spacing.s20)
                .padding(.vertical, Spacing.s16)
            Spacer()
        }
    }
}
