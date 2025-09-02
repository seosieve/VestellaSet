//
//  BeaconInfoView.swift
//  VestellaSet
//
//  Created by 서충원 on 9/2/25.
//

import SwiftUI

struct BeaconInfoView: View {
    let type: BeaconInfoType
    
    var body: some View {
        VStack(spacing: Spacing.s4) {
            Text(type.title)
                .foregroundStyle(Color.monoBase)
                .font(Manrope.regular(size: 14))
            Text(type.value)
                .foregroundStyle(Color.monoWhite)
                .font(Manrope.bold(size: 24))
        }
        .frame(maxWidth: .infinity)
    }
}
