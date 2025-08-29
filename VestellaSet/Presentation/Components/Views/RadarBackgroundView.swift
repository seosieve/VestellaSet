//
//  RadarBackgroundView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/29/25.
//

import SwiftUI

struct RadarBackgroundView: View {
    let size: CGFloat
    
    var body: some View {
        Circle()
            .foregroundStyle(Color.black.opacity(0.2))
            .frame(width: size, height: size)
        
        Circle()
            .foregroundStyle(Color.black.opacity(0.3))
            .frame(width: size * 0.75, height: size * 0.75)
    }
}
