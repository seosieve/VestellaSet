//
//  ScannerCornerView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/20/25.
//

import SwiftUI

struct ScannerCornerView: View {
    var cornerLength: CGFloat = 60
    var lineWidth: CGFloat = 4
    var cornerRadius: CGFloat = 12
    var color: Color = .mintBase
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size.width - Spacing.normal * 2
            let inset = lineWidth / 2
            
            ZStack {
                // Top-left
                Path { path in
                    path.move(to: CGPoint(x: inset, y: cornerLength + inset))
                    path.addLine(to: CGPoint(x: inset, y: cornerRadius + inset))
                    path.addQuadCurve(to: CGPoint(x: cornerRadius + inset, y: inset), control: CGPoint(x: inset, y: inset))
                    path.addLine(to: CGPoint(x: cornerLength + inset, y: inset))
                }
                .stroke(color, lineWidth: lineWidth)
                
                // Top-right
                Path { path in
                    path.move(to: CGPoint(x: size - cornerLength - inset, y: inset))
                    path.addLine(to: CGPoint(x: size - cornerRadius - inset, y: inset))
                    path.addQuadCurve(to: CGPoint(x: size - inset, y: cornerRadius + inset), control: CGPoint(x: size - inset, y: inset))
                    path.addLine(to: CGPoint(x: size - inset, y: cornerLength + inset))
                }
                .stroke(color, lineWidth: lineWidth)
                
                // Bottom-left
                Path { path in
                    path.move(to: CGPoint(x: inset, y: size - cornerLength - inset))
                    path.addLine(to: CGPoint(x: inset, y: size - cornerRadius - inset))
                    path.addQuadCurve(to: CGPoint(x: cornerRadius + inset, y: size - inset), control: CGPoint(x: inset, y: size - inset))
                    path.addLine(to: CGPoint(x: cornerLength + inset, y: size - inset))
                }
                .stroke(color, lineWidth: lineWidth)
                
                // Bottom-right
                Path { path in
                    path.move(to: CGPoint(x: size - cornerLength - inset, y: size - inset))
                    path.addLine(to: CGPoint(x: size - cornerRadius - inset, y: size - inset))
                    path.addQuadCurve(to: CGPoint(x: size - inset, y: size - cornerRadius - inset), control: CGPoint(x: size - inset, y: size - inset))
                    path.addLine(to: CGPoint(x: size - inset, y: size - cornerLength - inset))
                }
                .stroke(color, lineWidth: lineWidth)
            }
            .frame(width: size, height: size)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .ignoresSafeArea()
    }
}
