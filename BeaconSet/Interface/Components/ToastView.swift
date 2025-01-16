//
//  ToastView.swift
//  BeaconSet
//
//  Created by 서충원 on 1/14/25.
//

import SwiftUI

struct ToastView: View {
    var message: String
    
    @State private var isVisible = false
    
    var body: some View {
        ZStack {
            Color.red.opacity(0.5)
                .contentShape(Rectangle())
                .allowsHitTesting(true)
            
            Text(message)
                .padding()
                .background(Color.black.opacity(0.7))
                .foregroundColor(.white)
                .cornerRadius(10)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .opacity(isVisible ? 1 : 0)
                .offset(y: isVisible ? 0 : 20)
            
        }
        .animation(.spring(response: 0.3), value: isVisible)
        .onAppear {
            withAnimation {
                isVisible = true
            }
        }
    }
}
