//
//  BeaconTypeLabel.swift
//  VestellaSet
//
//  Created by 서충원 on 9/4/25.
//

import SwiftUI

struct BeaconTypeLabel: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(Manrope.regular(size: 16))
            .foregroundStyle(Color.monoDark)
            .frame(height: 36)
            .frame(maxWidth: .infinity)
            .background(Color.monoShadow)
            .cornerRadius(Radius.s8)
    }
}
