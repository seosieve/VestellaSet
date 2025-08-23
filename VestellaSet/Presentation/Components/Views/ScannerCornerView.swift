//
//  ScannerCornerView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/20/25.
//

import SwiftUI

struct ScannerCornerView: View {
    @Environment(\.scannerConfig) var config
    let inset = Scanner.lineWidth / 2
    
    var body: some View {
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
                path.move(to: CGPoint(x: config.length - Scanner.edgeLength - inset, y: inset))
                path.addLine(to: CGPoint(x: config.length - Radius.normal - inset, y: inset))
                path.addQuadCurve(to: CGPoint(x: config.length - inset, y: Radius.normal + inset),
                                  control: CGPoint(x: config.length - inset, y: inset))
                path.addLine(to: CGPoint(x: config.length - inset, y: Scanner.edgeLength + inset))
            }
            .stroke(Color.mintBase, lineWidth: Scanner.lineWidth)
            
            // BottomLeft
            Path { path in
                path.move(to: CGPoint(x: inset, y: config.length - Scanner.edgeLength - inset))
                path.addLine(to: CGPoint(x: inset, y: config.length - Radius.normal - inset))
                path.addQuadCurve(to: CGPoint(x: Radius.normal + inset, y: config.length - inset),
                                  control: CGPoint(x: inset, y: config.length - inset))
                path.addLine(to: CGPoint(x: Scanner.edgeLength + inset, y: config.length - inset))
            }
            .stroke(Color.mintBase, lineWidth: Scanner.lineWidth)
            
            // BottomRight
            Path { path in
                path.move(to: CGPoint(x: config.length - Scanner.edgeLength - inset, y: config.length - inset))
                path.addLine(to: CGPoint(x: config.length - Radius.normal - inset, y: config.length - inset))
                path.addQuadCurve(to: CGPoint(x: config.length - inset, y: config.length - Radius.normal - inset),
                                  control: CGPoint(x: config.length - inset, y: config.length - inset))
                path.addLine(to: CGPoint(x: config.length - inset, y: config.length - Scanner.edgeLength - inset))
            }
            .stroke(Color.mintBase, lineWidth: Scanner.lineWidth)
        }
        .frame(width: config.length, height: config.length)
        .position(config.center)
    }
}
