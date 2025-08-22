//
//  ScannerDimView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/21/25.
//

import SwiftUI

struct ScannerDimView: View {
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size.width - Spacing.normal * 2
            
            Color.monoBlack.opacity(0.9)
                .mask(
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .compositingGroup()
                            .luminanceToAlpha()
                        
                        RoundedRectangle(cornerRadius: Radius.normal)
                            .frame(width: size, height: size)
                            .blendMode(.destinationOut)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    }
                )
                .allowsHitTesting(false)
        }
        .ignoresSafeArea()
    }
}
