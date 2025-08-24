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
            .navigationBarBackButtonHidden()
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
                .padding(.horizontal, 4)
            Spacer()
        }
        .ignoresSafeArea(edges: .bottom)
        .monoBackground()
    }
    
    private var topBar: some View {
        HStack(spacing: 12) {
            Spacer()
            GlassButton(imageName: "Import") {
                store.send(.clickImportButton)
            }
            GlassButton(imageName: "Setting") {
                store.send(.clickSettingButton)
            }
        }
        .padding(.vertical, 12)
        .padding(.trailing, 20)
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
