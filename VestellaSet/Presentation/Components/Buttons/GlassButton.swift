//
//  GlassButton.swift
//  VestellaSet
//
//  Created by 서충원 on 8/20/25.
//

import SwiftUI

struct GlassButton: View {
    var image: Image
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 10)
            }
            .frame(width: 60, height: 40)
            .glassIconButtonStyle()
        }
        .buttonStyle(BouncyButtonStyle())
    }
}
