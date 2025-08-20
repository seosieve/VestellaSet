//
//  GlassButton.swift
//  VestellaSet
//
//  Created by 서충원 on 8/20/25.
//

import SwiftUI

struct GlassButton: View {
    var imageName: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(width: 60, height: 40)
        .background(Color.mintBase)
        .cornerRadius(30)
    }
}
