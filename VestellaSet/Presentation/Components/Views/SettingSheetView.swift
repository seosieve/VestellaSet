//
//  SettingSheetView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/27/25.
//

import SwiftUI
import ComposableArchitecture

struct SettingSheetView: View {
    let store: StoreOf<BeaconSettingFeature>
    
    var body: some View {
        ForEach(store.sheetType.item, id: \.index) { item in
            let isSelected = item.index == (store.sheetType == .interval ? store.interval : store.power)
            Button(action: { store.send(.selectSheetItem(item.index)) } ) {
                HStack(spacing: Spacing.s20) {
                    Text("\(item.index)")
                        .foregroundStyle(Color.monoWhite)
                        .font(Manrope.bold(size: 20))
                        .frame(width: 24)
                    Text(item.value)
                        .foregroundStyle(Color.monoMedium)
                        .font(Manrope.regular(size: 14))
                    Spacer()
                    
                    if isSelected {
                        Image.checkIcon
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(Color.monoWhite)
                    }
                }
                .frame(height: Sheet.itemHeight)
                .padding(.horizontal, Spacing.s20)
                .background(isSelected ? Color.monoDark.opacity(0.3) : Color.clear)
            }
        }
    }
}
