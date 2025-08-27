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
                    SettingSheetView(store: store)
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
                withAnimation(.easeInOut(duration: 0.2)) { offsetY = store.sheetType.height + 120 }
            }
        }
        .onAppear { offsetY = store.sheetType.height + 120 }
    }
}
