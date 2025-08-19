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
        NavigationStackStore(store.scope(state: \.navigationPath, action: \.navigationPath)) {
            Color.clear.onAppear { store.send(.onAppear) }
        } destination: { store in
            switch store.case {
            case .beaconDashBoard(let store):
                BeaconDashboardView(store: store)
            case .beaconImport(let store):
                BeaconImportView(store: store)
            case .beaconSetting(let store):
                BeaconSettingView(store: store)
            case .beaconScanner(let store):
                BeaconScannerView(store: store)
            case .beaconEditor(let store):
                BeaconEditorView(store:store)
            }
        }
    }
}
