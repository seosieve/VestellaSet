//
//  ContentView.swift
//  BeaconSet
//
//  Created by 베스텔라랩 on 12/30/24.
//

import SwiftUI
import MinewBeaconAdmin

struct ContentView: View {
    @StateObject private var beaconManager = BeaconManager()
    
    var body: some View {
        NavigationView {
            List(beaconManager.beacons, id: \.mac) { beacon in
                VStack(alignment: .leading) {
                    Text("MAC: \(beacon.mac ?? "Unknown")")
                        .font(.headline)
                    HStack() {
                        Text("UUID: \((beacon.uuid.flatMap { UUID(uuidString: $0) })?.uuidString ?? "Unknown")")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("RSSI: \(beacon.rssi)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    // aa
                    Button {
                        beaconManager.connect(to: beacon)
                    } label: {
                        Text("Connect")
                    }
                    .disabled(beaconManager.connectionState == .connected)
                }
            }
            .navigationTitle("Beacons")
            .toolbar {
                Button(action: {
                    beaconManager.startScanning()
                }) {
                    Text("Start Scan")
                }
            }
        }
        .onAppear {
            beaconManager.startScanning()
        }
        .onDisappear {
            beaconManager.stopScanning()
        }
    }
}
