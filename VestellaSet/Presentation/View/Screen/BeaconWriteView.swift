//
//  BeaconWriteView.swift
//  VestellaSet
//
//  Created by 서충원 on 12/31/24.
//

import SwiftUI

internal struct BeaconWriteView: View {
    @ObservedObject var model: BeaconDataViewModel
    @ObservedObject internal var beaconManager: BeaconManager
    internal let beacon: MinewBeacon
    let item: String
    let macAddress: String
    
    @Binding internal var isPresented: Bool
    
    internal var body: some View {
        HStack(alignment: .center) {
            Button("Save") {
                let newData = beaconManager.write(item: item, macAddress: macAddress)
                model.save(newData)
            }
            .font(.system(size: 12))
            .foregroundStyle(.white)
            .padding(30)
            .background(Color(.blue))
            .cornerRadius(10)
        }
        .padding()
        
        .onDisappear {
            beaconManager.disconnect()
        }
        .onChange(of: beaconManager.connectionState) { _, newState in
            print("🧊 \(newState)")
            isPresented = false
        }
    }
}
