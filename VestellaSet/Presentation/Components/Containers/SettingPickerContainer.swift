//
//  SettingPickerContainer.swift
//  VestellaSet
//
//  Created by 서충원 on 8/26/25.
//

import SwiftUI
import ComposableArchitecture

struct SettingPickerContainer: View {
    let store: StoreOf<BeaconSettingFeature>
    
    @State private var offsetY: CGFloat = UIScreen.main.bounds.height
    
    private let sheetHeight: CGFloat = 400
    
    var body: some View {
        ZStack {
            if store.isPicking {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        store.send(.stopPicking)
                    }
                    .transition(.opacity)
            }
            
            VStack {
                Spacer()
                VStack(spacing: 20) {
                    Text("Custom Bottom Sheet")
                        .font(.headline)
                    Text("여기에 원하는 UI를 넣으면 됩니다.")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: sheetHeight)
                .background(Color.monoBlack.opacity(0.7))
                .cornerRadius(16)
                .shadow(radius: 8)
                .offset(y: offsetY)
            }
        }
        .onChange(of: store.isPicking) { _, newValue in
            if newValue {
                withAnimation(.easeOut) {
                    offsetY = 0 // 위로 올라오기
                }
            } else {
                withAnimation(.easeIn) {
                    offsetY = sheetHeight + 100 // 다시 아래로
                }
            }
        }
        .onAppear {
            offsetY = sheetHeight + 100 // 시작 시 아래 숨김
        }
    }
}
