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
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(beaconManager.beacons, id: \.beaconIdentifier) { beacon in
                    NavigationLink(value: beacon) {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("RSSI: \(beacon.beaconRssi)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text("Major: \(beacon.beaconMajor)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text("Minor: \(beacon.beaconMinor)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
            .navigationDestination(for: MinewBeacon.self) { beacon in
                BeaconDetailView(beaconManager: beaconManager, beacon: beacon)
                    .onAppear {
                        beaconManager.stopScanning()
                    }
                    .onDisappear {
                        beaconManager.startScanning()
                    }
            }
            .navigationTitle("Beacons")
        }
        .onAppear {
            beaconManager.startScanning()
            print("💜 OnAppear")
        }
        .onChange(of: beaconManager.beacons.count) { _, newCount in
            isLoading = newCount < 0
        }
    }
}
