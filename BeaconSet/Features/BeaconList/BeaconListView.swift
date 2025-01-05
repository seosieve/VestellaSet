//
//  BeaconListView.swift
//  BeaconSet
//
//  Created by 베스텔라랩 on 12/30/24.
//

import SwiftUI
import MinewBeaconAdmin

struct BeaconListView: View {
    @StateObject private var beaconManager = BeaconManager()
    
    var body: some View {
        NavigationStack {
            List(beaconManager.beacons, id: \.id) { beacon in
                NavigationLink(destination: BeaconDetailView(beaconManager: beaconManager, beacon: beacon)) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("MAC: \(beacon.mac)")
                            .font(.system(size: 12))
                        Text("UUID: \(beacon.uuid ?? "Unknown")")
                            .font(.system(size: 12))
                        HStack {
                            Text("RSSI: \(beacon.rssi)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("Major: \(beacon.major)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("Minor: \(beacon.minor)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Beacons")
            .toolbar {
                Button(action: {
                    beaconManager.startScanning()
                }, label: {
                    Text("Start Scan")
                })
                Button(action: {
                    beaconManager.stopScanning()
                }, label: {
                    Text("Stop Scan")
                })
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
