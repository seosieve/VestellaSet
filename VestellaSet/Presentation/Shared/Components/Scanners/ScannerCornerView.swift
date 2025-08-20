//
//  CornerHighlightView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/20/25.
//

import SwiftUI

struct CornerHighlightView: View {
    var cornerLength: CGFloat = 60
    var lineWidth: CGFloat = 4
    var cornerRadius: CGFloat = 12
    var color: Color = .mintBase
    
    var body: some View {
        GeometryReader { geometry in
            let w = geometry.size.width
            let h = geometry.size.height
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
                    path.move(to: CGPoint(x: w - cornerLength - inset, y: inset))
                    path.addLine(to: CGPoint(x: w - cornerRadius - inset, y: inset))
                    path.addQuadCurve(to: CGPoint(x: w - inset, y: cornerRadius + inset), control: CGPoint(x: w - inset, y: inset))
                    path.addLine(to: CGPoint(x: w - inset, y: cornerLength + inset))
                }
                .stroke(color, lineWidth: lineWidth)
                
                // Bottom-left
                Path { path in
                    path.move(to: CGPoint(x: inset, y: h - cornerLength - inset))
                    path.addLine(to: CGPoint(x: inset, y: h - cornerRadius - inset))
                    path.addQuadCurve(to: CGPoint(x: cornerRadius + inset, y: h - inset), control: CGPoint(x: inset, y: h - inset))
                    path.addLine(to: CGPoint(x: cornerLength + inset, y: h - inset))
                }
                .stroke(color, lineWidth: lineWidth)
                
                // Bottom-right
                Path { path in
                    path.move(to: CGPoint(x: w - cornerLength - inset, y: h - inset))
                    path.addLine(to: CGPoint(x: w - cornerRadius - inset, y: h - inset))
                    path.addQuadCurve(to: CGPoint(x: w - inset, y: h - cornerRadius - inset), control: CGPoint(x: w - inset, y: h - inset))
                    path.addLine(to: CGPoint(x: w - inset, y: h - cornerLength - inset))
                }
                .stroke(color, lineWidth: lineWidth)
            }
        }
    }
}
