//
//  EmptyBeaconListLabel.swift
//  VestellaSet
//
//  Created by 서충원 on 9/29/25.
//

import SwiftUI
import ComposableArchitecture

struct EmptyBeaconListLabel: View {
    let store: StoreOf<BeaconDashBoardFeature>
    
    var body: some View {
        VStack(spacing: Spacing.s12) {
            Image.emptyList
                .resizable()
                .frame(width: 36, height: 36)
                .foregroundStyle(Color.monoDark)
            
            Text(TextMessage.emptyList)
                .font(Manrope.regular(size: 16))
                .foregroundStyle(Color.monoDark)
        }
        .opacity(store.filteredList.isEmpty ? 1 : 0)
        .padding(.bottom, Spacing.s100)
    }
}
