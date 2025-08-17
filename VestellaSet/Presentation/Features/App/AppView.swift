//
//  AppView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/16/25.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    let store: StoreOf<AppFeature>
    
    var body: some View {
        NavigationStackStore(store.scope(state: \.path, action: \.path)) {
            BeaconDashboardView(store: store.scope(state: \.dashboard, action: \.dashboard))
        } destination: { destinationStore in
            SwitchStore(destinationStore) { store in
                switch store {
                case .beaconConfig:
                    CaseLet(\Destination.State.beaconConfig, action: Destination.Action.beaconConfig, then: BeaconConfigView.init)
                case .beaconScanner:
                    CaseLet(\Destination.State.beaconScanner, action: Destination.Action.beaconScanner, then: BeaconScannerView.init)
                }
            }
        }
    }
}
