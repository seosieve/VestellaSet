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
                        Button(action: { store.send(.changeValue(item.index)) } ) {
                            HStack(spacing: Spacing.s20) {
                                Text("\(item.index)")
                                    .foregroundStyle(Color.monoWhite)
                                    .font(Manrope.bold(size: 20))
                                Text(item.value)
                                    .foregroundStyle(Color.monoMedium)
                                    .font(Manrope.regular(size: 14))
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .frame(height: Sheet.itemHeight)
                            .padding(.horizontal, Spacing.s20)
                            .background(item.index == store.interval ? Color.monoWhite.opacity(0.1) : Color.clear)
                        }
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                    .animation(.bouncy, value: store.isSheetPresented)
                }
                .padding(.vertical, Spacing.s8)
                .frame(maxWidth: .infinity)
                .glassSettingSheetStyle()
                .offset(y: offsetY)
                .padding(.horizontal, Spacing.s20)
            }
        }
        .onChange(of: store.isSheetPresented) { _, newValue in
            if newValue {
                withAnimation(.bouncy) { offsetY = 0 }
            } else {
                withAnimation(.bouncy) { offsetY = store.sheetType.height + 120 }
            }
        }
        .onAppear { offsetY = store.sheetType.height + 120 }
    }
}
