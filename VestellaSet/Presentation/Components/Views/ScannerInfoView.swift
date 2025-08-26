//
//  ScannerInfoView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/23/25.
//

import SwiftUI

struct ScannerInfoView: View {
    let type: ScannerInfoType
    
    var body: some View {
        HStack(spacing: Spacing.s12) {
            Text(type.title)
                .foregroundColor(.white)
                .font(Manrope.regular(size: 14))
            Text("\(type.value)")
                .foregroundColor(.mintBase)
                .font(Manrope.bold(size: 20))
        }
        .frame(maxWidth: .infinity, maxHeight: 70)
        .background(Color.monoBlack)
        .clipShape(RoundedRectangle(cornerRadius: Radius.s8))
        .shadow(color: .black.opacity(0.5), radius: 8, x: 2, y: 4)
    }
}
