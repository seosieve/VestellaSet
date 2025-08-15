//
//  HomeView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/10/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var model = BeaconDataViewModel()
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            content
                .navigationBarHidden(true)
                .navigationDestination(for: String.self) { item in
                    OCRReaderView(model: model, path: $path, item: item)
                }
//                .navigationDestination(for: Int.self) { setting in
//                    SettingView(model: model)
//                }
        }
        .task {
            printMyAppUserDefaults()
        }
    }
}

// MARK: - UI Components
extension HomeView {
    private var content: some View {
        VStack {
            topBar
            Spacer()
            BeaconListView(value: model.data)
            Spacer()
        }
    }
    
    private var topBar: some View {
        HStack {
            Spacer()
            SettingButton(value: 1)
        }
    }
}

// MARK: - Methods
extension HomeView {
    func printMyAppUserDefaults() {
        let prefix = UserDefaultsKey.prefix
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        
        for (key, value) in dictionary where key.hasPrefix(prefix) {
            print("🕹️ \(key) : \(value)")
        }
    }
}
