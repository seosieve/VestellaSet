//
//  SettingPickerContainer.swift
//  VestellaSet
//
//  Created by 서충원 on 8/26/25.
//

import SwiftUI

struct SettingPickerContainer: View {
    @Binding var isPresented: Bool
    @State private var offsetY: CGFloat = 400
    
    private let maxHeight: CGFloat = 300
    
    var body: some View {
        VStack {
            // Content
            VStack(spacing: 20) {
                Text("Custom Bottom Sheet")
                    .font(.headline)
                Text("여기에 원하는 UI를 넣으면 됩니다.")
            }
            .padding()
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: maxHeight)
        .background(Color.monoBlack.opacity(0.9))
        .cornerRadius(16)
        .shadow(radius: 8)
        .offset(y: offsetY)
        .gesture(
            DragGesture()
                .onChanged { value in
                    if value.translation.height > 0 {
                        offsetY = value.translation.height
                    }
                }
                .onEnded { value in
                    if value.translation.height > 100 {
                        withAnimation(.easeInOut) { isPresented = false }
                    }
                    offsetY = 0
                }
        )
        .onAppear {
             withAnimation(.easeOut) {
                 offsetY = 0
             }
         }
        .padding(.horizontal, Spacing.s20)
    }
}
