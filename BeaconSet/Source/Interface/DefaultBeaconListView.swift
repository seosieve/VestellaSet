//
//  DefaultBeaconListView.swift
//  BeaconSet
//
//  Created by 서충원 on 1/2/25.
//

import SwiftUI

struct DefaultBeaconListView: View {
    @StateObject private var defaultBeaconManager = DefaultBeaconManager()
    
    var body: some View {
        VStack {
            Text("📡 Beacon Scanner")
                .font(.largeTitle)
                .padding()
            
            List(defaultBeaconManager.beacons, id: \.id) { beacon in
                VStack(alignment: .leading) {
                    Text("UUID: \(beacon.uuid)")
                    Text("Major: \(beacon.major)")
                    Text("Minor: \(beacon.minor)")
                }
                .padding(5)
            }

            Button {
                defaultBeaconManager.startScanning()
            } label: {
                Text("Start Scanning")
                    .font(.headline)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Button {
                defaultBeaconManager.stopScanning()
            } label: {
                Text("Stop Scanning")
                    .font(.headline)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .onAppear {
            defaultBeaconManager.startScanning()
        }
    }
}
