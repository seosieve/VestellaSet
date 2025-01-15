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
    @State private var isLoading = true
    @State private var isShowing = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(beaconManager.minewBeacons, id: \.deviceId) { beacon in
                    NavigationLink(value: beacon) {
                        BeaconListItemView(beacon: beacon)
                    }
                }
                if isShowing {
                    ToastView(message: "Loading...")
                }
            }
            .navigationDestination(for: MinewBeacon.self) { beacon in
                BeaconDetailView(beaconManager: beaconManager, beacon: beacon)
                    .onAppear {
                        beaconManager.stopScanning()
                        beaconManager.connect(to: beacon)
                    }
                    .onDisappear {
                        beaconManager.startScanning()
                        beaconManager.disconnect()
                    }
            }
            .navigationTitle("MinewBeacons")
            .onAppear {
                beaconManager.startScanning()
            }
            .onChange(of: beaconManager.beacons.count) { _, newCount in
                isLoading = newCount < 0
            }
        }
    }
}
