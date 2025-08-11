//
//  BeaconDetailView.swift
//  VestellaSet
//
//  Created by 서충원 on 12/31/24.
//

import SwiftUI

internal struct BeaconDetailView: View {
    @ObservedObject var model: BeaconDataViewModel
    @ObservedObject internal var beaconManager: BeaconManager
    internal let beacon: MinewBeacon
    let item: String
    let macAddress: String
    
    @Binding internal var isPresented: Bool
    
    private var beaconDetails: [BeaconDetail] {
        guard let setting = beaconManager.currentSetting else { return [BeaconDetail]() }
        
        return [
            BeaconDetail(title: "Battery", value: String(setting.battery)),
            BeaconDetail(title: "UUID", value: setting.uuid),
            BeaconDetail(title: "Major", value: String(setting.major)),
            BeaconDetail(title: "Minor", value: String(setting.minor)),
            BeaconDetail(title: "Measured Distance", value: String(setting.calibratedTxPower)),
            BeaconDetail(title: "Transmission Power", value: String(setting.txPower)),
            BeaconDetail(title: "Broadcast Interval", value: String(setting.broadcastInterval)),
            BeaconDetail(title: "MAC Address", value: setting.mac),
            BeaconDetail(title: "iBeacon Name", value: setting.name ?? "N/A")
        ]
    }
    
    internal var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .lastTextBaseline) {
                Spacer()
                Button("Save") {
                    let newData = beaconManager.write(item: item, macAddress: macAddress)
                    model.save(newData)
                }
                .font(.system(size: 12))
                .foregroundStyle(.black)
                .padding(10)
                .background(Color(.secondarySystemBackground))
            }
            .padding()
        }
        .onDisappear {
            beaconManager.disconnect()
        }
        .onChange(of: beaconManager.connectionState) { _, newState in
            print("🧊 \(newState)")
            isPresented = false
        }
    }
}
