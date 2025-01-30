//
//  BeaconSetApp.swift
//  BeaconSet
//
//  Created by 베스텔라랩 on 12/19/24.
//

import SwiftUI

@main
internal struct BeaconSetApp: App {
    internal init() {
        customizeRefreshControlAppearance()
    }
    
    internal var body: some Scene {
        WindowGroup {
            BeaconListView()
        }
    }
}

// MARK: - Helper Methods
extension BeaconSetApp {
    private func customizeRefreshControlAppearance() {
        UIRefreshControl.appearance().tintColor = UIColor.lightGray.withAlphaComponent(0.4)
    }
}
