//
//  LoadingDotsView.swift
//  VestellaSet
//
//  Created by 서충원 on 9/2/25.
//

import SwiftUI

struct LoadingDotsView: View {
    @State private var scales = Array(repeating: 1.0, count: 3)
    
    var body: some View {
        HStack(spacing: Spacing.s12) {
            ForEach(0..<3, id: \.self) { index in
                Circle()
                    .foregroundStyle(Color.mintShadow)
                    .frame(width: 8, height: 8)
                    .scaleEffect(scales[index])
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .onAppear {
            Task {
                while true {
                    for i in 0..<3 { await animateDot(i) }
                    withAnimation(.interpolatingSpring(stiffness: 150, damping: 10)) { scales[2] = 1.0 }
                    try? await Task.sleep(nanoseconds: 900_000_000)
                }
            }
        }
    }
    
    func animateDot(_ index: Int) async {
        withAnimation(.interpolatingSpring(stiffness: 150, damping: 10)) { scales[index] = 2 }
        if index > 0 {
            withAnimation(.interpolatingSpring(stiffness: 150, damping: 10)) { scales[index - 1] = 1.0 }
        }
        try? await Task.sleep(nanoseconds: 150_000_000)
    }
}
