//
//  ScannerInfoContainer.swift
//  VestellaSet
//
//  Created by 서충원 on 8/23/25.
//

import SwiftUI
import ComposableArchitecture

struct ScannerInfoContainer: View {
    let store: StoreOf<BeaconImportFeature>
    
    @Environment(\.scannerConfig) var config
    
    var body: some View {
        HStack(spacing: Spacing.s8) {
            ScannerInfoView(type: .major(store.major))
            ScannerInfoView(type: .count(store.count))
        }
        .opacity(store.isFinished ? 1 : 0)
        .animation(.easeInOut, value: store.isFinished)
        .padding(.horizontal, Spacing.s20)
        .offset(y: -(config.length / 2) - Spacing.s52)
    }
}
