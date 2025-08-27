//
//  SettingSheetContainer.swift
//  VestellaSet
//
//  Created by 서충원 on 8/26/25.
//

import SwiftUI
import ComposableArchitecture

struct SettingSheetContainer: View {
    let store: StoreOf<BeaconSettingFeature>
    
    @State private var offsetY: CGFloat = 0
    
    private let sheetHeight: CGFloat = 400
    
    var body: some View {
        ZStack {
            if store.isSheetPresented {
                SettingDimView { store.send(.hideSheet) }
            }
            
            VStack {
                Spacer()
                VStack(spacing: 0) {
                    SettingSheetTitleLabel(title: store.sheetType.title)
                    ForEach(store.sheetType.item, id: \.id) { item in
                        Button(action: {store.send(.hideSheet)}) {
                            HStack(spacing: Spacing.s20) {
                                Text("\(item.index)")
                                Text(item.value)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .frame(minHeight: 48)
                            .padding(.horizontal, 20)
                        }
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                    .animation(.bouncy, value: store.isSheetPresented)
                }
                .padding(.vertical, Spacing.s8)
                .frame(maxWidth: .infinity)
                .background(Color.monoBlack.opacity(0.4))
                .cornerRadius(16)
                .shadow(radius: 8)
                .offset(y: offsetY)
                .padding(.horizontal, Spacing.s20)
            }
        }
        .onChange(of: store.isSheetPresented) { _, newValue in
            if newValue {
                withAnimation(.bouncy) {
                    offsetY = 0 // 위로 올라오기
                }
            } else {
                withAnimation(.bouncy) {
                    offsetY = sheetHeight + 100 // 다시 아래로
                }
            }
        }
        .onAppear {
            offsetY = sheetHeight + 100 // 시작 시 아래 숨김
        }
    }
}
