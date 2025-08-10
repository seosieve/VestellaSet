//
//  BeaconMainView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/10/25.
//

import SwiftUI

struct BeaconMainView: View {
    @StateObject private var model = BeaconDataViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    settingButton
                }
                Spacer()
                beacoList
                Spacer()
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            setMyAppUserDefaults()
            printMyAppUserDefaults()
        }
    }
}

// MARK: - UI Components
extension BeaconMainView {
    private var settingButton: some View {
        NavigationLink(destination: BeaconSettingView(model: model)) {
            Text("Setting")
                .foregroundColor(.blue)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        }
        .padding()
    }
    
    private var beacoList: some View {
        List(model.data, id: \.self) { item in
            NavigationLink(destination: MacReaderView()) {
                Text(item)
                    .padding()
            }
        }
    }
}

// MARK: - Methods
extension BeaconMainView {    
    func setMyAppUserDefaults() {
        UserDefaults.standard.set(4, forKey: "myApp_broadcastInterval")
        UserDefaults.standard.set(3, forKey: "myApp_txPower")
    }
    
    func printMyAppUserDefaults() {
        let prefix = "myApp_"
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        
        for (key, value) in dictionary where key.hasPrefix(prefix) {
            print("🕹️ \(key) : \(value)")
        }
    }
}
