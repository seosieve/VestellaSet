//
//  TextFieldContainer.swift
//  VestellaSet
//
//  Created by 서충원 on 8/25/25.
//

import SwiftUI

struct TextFieldContainer: View {
    var body: some View {
        HStack {
            Text("UUID")
                .foregroundStyle(Color.white.opacity(0.7))
                .font(Manrope.regular(size: 16))
                .padding(.leading, 20)
                
            Spacer()
            Text("FJ234211313")
                .font(Manrope.bold(size: 16))
                .padding(.trailing, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: 52)
        .glassActionButtonStyle()
        .padding(.horizontal, Spacing.normal)
    }
}
