//
//  ScannerDimView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/20/25.
//

import SwiftUI

struct ScannerDimView: View {
    var body: some View {
        GeometryReader { geometry in
            let overlayWidth = geometry.size.width - Spacing.normal * 2
            let overlayHeight = overlayWidth
            let overlaySize = CGSize(width: overlayWidth, height: overlayHeight)
            
            ZStack {
                Color.monoBlack.opacity(0.9)
                    .mask(
                        maskRectangle
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: overlaySize.width, height: overlaySize.height)
                                    .blendMode(.destinationOut)
                                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                            )
                    )
                    .allowsHitTesting(false)
                
                CornerHighlightView()
                    .frame(width: overlaySize.width, height: overlaySize.height)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                
                ScannerLineView()
                    .frame(width: overlaySize.width, height: overlaySize.height)
                    .mask(
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: overlaySize.width, height: overlaySize.height)
                    )
            }
        }
        .ignoresSafeArea()
    }
}

extension ScannerDimView {
    private var maskRectangle: some View {
        Rectangle()
            .fill(Color.white)
            .compositingGroup()
            .luminanceToAlpha()
    }
}
