//
//  TitleLabel.swift
//  VestellaSet
//
//  Created by 베스텔라랩 on 8/26/25.
//

import SwiftUI

struct TitleLabel: View {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(Manrope.extraBold(size: 28))
            .padding(.top, Spacing.s32)
            .padding(.bottom, Spacing.s8)
    }
}
