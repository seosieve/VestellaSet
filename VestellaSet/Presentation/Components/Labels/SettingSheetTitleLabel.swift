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
        Text(title)
            .font(.headline)
            .padding(.vertical, Spacing.s16)
    }
}
