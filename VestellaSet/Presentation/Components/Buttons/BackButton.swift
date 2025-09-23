//
//  BackButton.swift
//  VestellaSet
//
//  Created by 서충원 on 8/21/25.
//

import SwiftUI

struct BackButton: View {
    var action: () -> Void
    
    var body: some View {
        HStack {
            GlassIconButton(image: .xmarkIcon) { action() }
            Spacer()
        }
        .padding(.top, Spacing.s12)
        .padding(.leading, Spacing.s20)
    }
}

