//
//  AppView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/16/25.
//

import SwiftUI
import ComposableArchitecture

enum Destination: Hashable {
    case beaconConfig
    case beaconScanner(target: String)
    case beaconEditor(macAddress: String, target: String)
}

struct AppView: View {
    let store: StoreOf<AppFeature>
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            BeaconDashboardView(path: $path)
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                    case .beaconConfig: BeaconConfigView()
                    case let .beaconScanner(target): BeaconScannerView(path: $path, target: target)
                    case let .beaconEditor(macAddress, target): BeaconEditorView(path: $path, macAddress: macAddress, target: target)
                    }
                }
        }
    }
}
