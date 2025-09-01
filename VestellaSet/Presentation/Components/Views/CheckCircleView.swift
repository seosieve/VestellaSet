//
//  CheckCircleView.swift
//  VestellaSet
//
//  Created by 서충원 on 9/1/25.
//

import SwiftUI

struct CheckCircleView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.mintBase)
                .frame(width: 20, height: 20)
            
            Image.checkIcon
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundStyle(Color.mintBlack)
        }
    }
}
