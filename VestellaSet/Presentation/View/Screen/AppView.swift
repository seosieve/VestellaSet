//
//  AppView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/16/25.
//

import SwiftUI

enum Destination: Hashable {
    case setting
    case ocrReader(target: String)
    case beaconConnect(macAddress: String, target: String)
}

struct AppView: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            HomeView(path: $path)
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                    case .setting: SettingView()
                    case let .ocrReader(target): OCRReaderView(path: $path, target: target)
                    case let .beaconConnect(macAddress, target): BeaconConnectView(path: $path, macAddress: macAddress, target: target)
                    }
                }
        }
    }
}
