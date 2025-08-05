//
//  ToastView.swift
//  BeaconSet
//
//  Created by 서충원 on 1/14/25.
//

import SwiftUI

internal struct LoadingToastView: View {
    @State private var isVisible = false
    
    internal var body: some View {
        ZStack {
            Color.clear
                .ignoresSafeArea()
                .allowsHitTesting(true)
            Text("Loading...")
                .padding()
                .background(Color.black.opacity(0.7))
                .foregroundColor(.white)
                .cornerRadius(10)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .opacity(isVisible ? 1 : 0)
                .offset(y: isVisible ? 0 : 20)
            
        }
        .animation(.spring(response: 1.0), value: isVisible)
        .onAppear {
            isVisible = true
        }
    }
}
