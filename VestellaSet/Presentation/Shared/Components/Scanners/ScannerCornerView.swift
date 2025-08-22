//
//  ScannerCornerView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/20/25.
//

import SwiftUI

struct ScannerCornerView: View {
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size.width - Spacing.normal * 2
            let inset = Scanner.lineWidth / 2
            
            ZStack {
                // TopLeft
                Path { path in
                    path.move(to: CGPoint(x: inset, y: Scanner.edgeLength + inset))
                    path.addLine(to: CGPoint(x: inset, y: Radius.normal + inset))
                    path.addQuadCurve(to: CGPoint(x: Radius.normal + inset, y: inset), control: CGPoint(x: inset, y: inset))
                    path.addLine(to: CGPoint(x: Scanner.edgeLength + inset, y: inset))
                }
                .stroke(Color.mintBase, lineWidth: Scanner.lineWidth)
                
                // TopRight
                Path { path in
                    path.move(to: CGPoint(x: size - Scanner.edgeLength - inset, y: inset))
                    path.addLine(to: CGPoint(x: size - Radius.normal - inset, y: inset))
                    path.addQuadCurve(to: CGPoint(x: size - inset, y: Radius.normal + inset), control: CGPoint(x: size - inset, y: inset))
                    path.addLine(to: CGPoint(x: size - inset, y: Scanner.edgeLength + inset))
                }
                .stroke(Color.mintBase, lineWidth: Scanner.lineWidth)
                
                // BottomLeft
                Path { path in
                    path.move(to: CGPoint(x: inset, y: size - Scanner.edgeLength - inset))
                    path.addLine(to: CGPoint(x: inset, y: size - Radius.normal - inset))
                    path.addQuadCurve(to: CGPoint(x: Radius.normal + inset, y: size - inset), control: CGPoint(x: inset, y: size - inset))
                    path.addLine(to: CGPoint(x: Scanner.edgeLength + inset, y: size - inset))
                }
                .stroke(Color.mintBase, lineWidth: Scanner.lineWidth)
                
                // BottomRight
                Path { path in
                    path.move(to: CGPoint(x: size - Scanner.edgeLength - inset, y: size - inset))
                    path.addLine(to: CGPoint(x: size - Radius.normal - inset, y: size - inset))
                    path.addQuadCurve(to: CGPoint(x: size - inset, y: size - Radius.normal - inset), control: CGPoint(x: size - inset, y: size - inset))
                    path.addLine(to: CGPoint(x: size - inset, y: size - Scanner.edgeLength - inset))
                }
                .stroke(Color.mintBase, lineWidth: Scanner.lineWidth)
            }
            .frame(width: size, height: size)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .ignoresSafeArea()
    }
}
