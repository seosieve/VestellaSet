//
//  TargetInfoLabel.swift
//  VestellaSet
//
//  Created by 서충원 on 10/1/25.
//

import SwiftUI

struct TargetInfoLabel: View {
    var body: some View {
        Text("")
            .font(Manrope.regular(size: 16))
            .foregroundStyle(Color.monoDark)
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.monoShadow)
            .cornerRadius(Radius.s8)
            .padding(.top, Spacing.s12)
            .padding(.trailing, Spacing.s20)
    }
}
