//
//  ToastView.swift
//  BeaconSet
//
//  Created by 서충원 on 1/14/25.
//

import SwiftUI

struct ToastView: View {
    var message: String
    
    var body: some View {
        Text(message)
            .padding()
            .background(Color.black.opacity(0.7))
            .foregroundColor(.white)
            .cornerRadius(10)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .transition(.opacity)
            .animation(.easeInOut, value: UUID())
    }
}
