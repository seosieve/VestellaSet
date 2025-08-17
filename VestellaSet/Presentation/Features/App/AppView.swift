//
//  AppView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/16/25.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    var store: StoreOf<AppFeature>
    
    var body: some View {
        NavigationStackStore(store.scope(state: \.path, action: \.path)) {
            BeaconDashboardView(store: store.scope(state: \.dashboard, action: \.dashboard))
        } destination: { destination in
            SwitchStore(destination) { pathStore in
                switch pathStore {
                case .beaconImport:
                    let store = store.scope(state: \.dashboard.beaconImport, action: \.dashboard.beaconImport)
                    BeaconImportView(store: store)
                case .beaconConfig:
                    let store = store.scope(state: \.dashboard.beaconSetting, action: \.dashboard.beaconSetting)
                    BeaconSettingView(store: store)
                case .beaconScanner:
                    let store = store.scope(state: \.dashboard.beaconScanner, action: \.dashboard.beaconScanner)
                    BeaconScannerView(store: store)
                case .beaconEditor:
                    let store = store.scope(state: \.dashboard.beaconScanner.beaconEditor, action: \.dashboard.beaconScanner.beaconEditor)
                    BeaconEditorView(store:store)
                }
            }
        }
    }
}
