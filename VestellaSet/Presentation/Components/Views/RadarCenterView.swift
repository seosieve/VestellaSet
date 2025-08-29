//
//  RadarCenterView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/29/25.
//

import SwiftUI

struct RadarCenterView: View {
    var body: some View {
        Circle()
            .stroke(Color.mintBase, lineWidth: 4)
            .background(Circle().foregroundStyle(Color.monoBlack))
            .frame(width: 80, height: 80)
        
        Image.bluetoothIcon
            .resizable()
            .frame(width: 46, height: 46)
            .foregroundColor(.monoWhite)
    }
}
