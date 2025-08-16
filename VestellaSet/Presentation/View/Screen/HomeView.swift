//
//  HomeView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/10/25.
//

import SwiftUI

struct HomeView: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        content
            .navigationBarHidden(true)
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
            BeaconListView()
            Spacer()
        }
    }
    
    private var topBar: some View {
        HStack {
            Spacer()
            SettingButton()
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
