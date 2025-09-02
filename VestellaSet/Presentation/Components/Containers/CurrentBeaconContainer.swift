//
//  CurrentBeaconContainer.swift
//  VestellaSet
//
//  Created by 서충원 on 9/2/25.
//

import SwiftUI
import ComposableArchitecture

struct CurrentBeaconContainer: View {
    let store: StoreOf<BeaconEditorFeature>
    
    var body: some View {
        HStack {
            BeaconInfoView(type: .major(store.beacon))
            DividerView(length: 32)
            BeaconInfoView(type: .minor(store.beacon))
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(Color.monoShadow.cornerRadius(Radius.s8))
        .padding(.horizontal, Spacing.s20)
    }
}
