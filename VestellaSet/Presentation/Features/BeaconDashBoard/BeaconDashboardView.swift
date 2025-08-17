//
//  BeaconDashboardView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/10/25.
//

import SwiftUI
import ComposableArchitecture

struct BeaconDashboardView: View {
    let store: StoreOf<BeaconDashBoardFeature>
    
    var body: some View {
        content
            .padding()
            .navigationBarHidden(true)
            .task {
                printMyAppUserDefaults()
            }
    }
}

// MARK: - UI Components
extension BeaconDashboardView {
    private var content: some View {
        VStack {
            topBar
            Spacer()
            BeaconListView(store: store)
            Spacer()
        }
    }
    
    private var topBar: some View {
        HStack {
            Spacer()
            ImportButton(store: store)
            ConfigButton(store: store)
        }
    }
}

// MARK: - Methods
extension BeaconDashboardView {
    func printMyAppUserDefaults() {
        let prefix = UserDefaultsKey.prefix
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        
        for (key, value) in dictionary where key.hasPrefix(prefix) {
            print("🕹️ \(key) : \(value)")
        }
    }
}
