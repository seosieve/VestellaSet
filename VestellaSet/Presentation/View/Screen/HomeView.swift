//
//  HomeView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/10/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var model = BeaconDataViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    settingButton
                }
                Spacer()
                beaconList
                Spacer()
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            printMyAppUserDefaults()
        }
    }
}

// MARK: - UI Components
extension HomeView {
    private var settingButton: some View {
        NavigationLink(destination: SettingView(model: model)) {
            Text("Setting")
                .foregroundColor(.blue)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        }
        .padding()
    }
    
    private var beaconList: some View {
        List(model.data, id: \.self) { item in
            NavigationLink(destination: BeaconReaderView(model: model, item: item)) {
                Text(item)
                    .padding()
            }
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
