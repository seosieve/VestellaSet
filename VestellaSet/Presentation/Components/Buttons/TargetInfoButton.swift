//
//  TargetInfoButton.swift
//  VestellaSet
//
//  Created by 서충원 on 10/1/25.
//

import SwiftUI
import ComposableArchitecture

struct TargetInfoButton: View {
    let store: StoreOf<BeaconEditorFeature>
    
    var body: some View {
        Menu {
            Button(action: {}) {
                Text(SettingSheetType.uuid.title)
                Text(store.uuid)
            }
            Button(action: {}) {
                Text(SettingSheetType.interval.title)
                Text("\(store.interval) (\(SettingSheetType.interval.item[store.interval - 1].value))")
            }
            Button(action: {}) {
                Text(SettingSheetType.power.title)
                Text("\(store.power) (\(SettingSheetType.power.item[store.power - 1].value))")
            }
        } label: {
            ZStack {
                Image.infoIcon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundStyle(Color.monoWhite)
                    .padding(.vertical, 10)
            }
            .frame(width: 60, height: 40)
        }
        .glassIconButtonStyle()
        .padding(.top, Spacing.s12)
        .padding(.trailing, Spacing.s20)
    }
}
