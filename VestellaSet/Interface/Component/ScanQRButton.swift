//
//  ScanQRButton.swift
//  VestellaSet
//
//  Created by 서충원 on 8/9/25.
//

import SwiftUI

struct ScanQRButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            EmptyView()
        }
        .frame(width: 24, height: 24)
        .padding(16)
        .background(Color.gray)
        .clipShape(Circle())
    }
}
