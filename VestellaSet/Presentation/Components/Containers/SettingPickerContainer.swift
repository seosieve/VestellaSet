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
    
    @State private var offsetY: CGFloat = 0
    
    private let sheetHeight: CGFloat = 400
    
    struct Item: Identifiable {
        let id = UUID()
        let name: String
    }

    // 예시 데이터
    let items: [Item] = [
        Item(name: "첫 번째 항목"),
        Item(name: "두 번째 항목"),
        Item(name: "세 번째 항목"),
        Item(name: "네 번째 항목"),
        Item(name: "다섯 번째 항목"),
        Item(name: "여섯 번째 항목"),
        Item(name: "일곱 번째 항목"),
        Item(name: "일곱 번째 항목"),
        Item(name: "일곱 번째 항목"),
    ]
    
    var body: some View {
        ZStack {
            if store.isPicking {
                SettingDimView { store.send(.stopPicking) }
            }
            
            VStack {
                Spacer()
                VStack(spacing: 0) {
                    Text(store.pickerType.title)
                        .font(.headline)
                        .padding(.vertical, Spacing.s16)
                    ForEach(items, id: \.id) { item in
                        Button(action: {store.send(.stopPicking)}) {
                            HStack {
                                Text(item.name)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .frame(minHeight: 48)
                            .background(Color.gray.opacity(0.1))
                        }
                    }
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
        .onChange(of: store.isPicking) { _, newValue in
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
