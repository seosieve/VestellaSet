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
        HStack(spacing: Spacing.small) {
            ScannerInfoView(value: 245)
            ScannerInfoView(value: 760)
        }
        .padding(.horizontal, Spacing.large)
        .offset(y: -(config.length / 2) - 55)
    }
}
