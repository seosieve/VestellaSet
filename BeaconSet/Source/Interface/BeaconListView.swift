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
            List(beaconManager.beacons, id: \.mac) { beacon in
                NavigationLink(destination: DetailView(beaconManager: beaconManager, beacon: beacon)) {
                    VStack(alignment: .leading) {
                        Text("MAC: \(beacon.mac ?? "Unknown")")
                            .font(.headline)
                        HStack {
                            Text("RSSI: \(beacon.rssi)")
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
