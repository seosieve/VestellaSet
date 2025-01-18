//
//  BeaconDetailView.swift
//  BeaconSet
//
//  Created by 서충원 on 12/31/24.
//

import SwiftUI

struct BeaconDetailView: View {
    @ObservedObject var beaconManager: BeaconManager
    
    let beacon: MinewBeacon
    
    var body: some View {
        List {
            HStack {
                Text("Battery")
                Spacer()
                Text("\(beaconManager.currentSetting?.battery)")
                    .font(.system(size: 12))
            }
            HStack {
                Text("UUID")
                Spacer()
                Text("UUID")
                    .font(.system(size: 12))
            }
            HStack {
                Text("Major")
                Spacer()
                Text("Major")
                    .font(.system(size: 12))
            }
            HStack {
                Text("Minor")
                Spacer()
                Text("Minor")
                    .font(.system(size: 12))
            }
            HStack {
                Text("Measured Distance")
                Spacer()
                Text("Measured Distance")
                    .font(.system(size: 12))
            }
            HStack {
                Text("Transmission Power")
                Spacer()
                Text("Transmission Power")
                    .font(.system(size: 12))
            }
            HStack {
                Text("Broadcast Interval")
                Spacer()
                Text("Broadcast Interval")
                    .font(.system(size: 12))
            }
            HStack {
                Text("MAC Adress")
                Spacer()
                Text("MAC Adress")
                    .font(.system(size: 12))
            }
            HStack {
                Text("iBeacon Name")
                Spacer()
                Text("iBeacon Name")
                    .font(.system(size: 12))
            }
        }
        .onAppear {
            beaconManager.read()
        }
        .onDisappear {
            beaconManager.disconnect()
        }
        .onChange(of: beaconManager.currentSetting) { newValue in
            print("🌱")
            print(newValue)
        }
    }
}
