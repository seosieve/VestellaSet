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
    @State private var 
    
    var body: some View {
//        NavigationStack {
//            ZStack {
//                List(beaconManager.beacons, id: \.id) { beacon in
//                    NavigationLink(value: beacon) {
//                        VStack(alignment: .leading, spacing: 4) {
//                            Text("MAC: \(beacon.mac)")
//                                .font(.system(size: 12))
//                            Text("UUID: \(beacon.uuid ?? "Unknown")")
//                                .font(.system(size: 12))
//                            HStack {
//                                Text("RSSI: \(beacon.rssi)")
//                                    .font(.subheadline)
//                                    .foregroundColor(.secondary)
//                                Text("Major: \(beacon.major)")
//                                    .font(.subheadline)
//                                    .foregroundColor(.secondary)
//                                Text("Minor: \(beacon.minor)")
//                                    .font(.subheadline)
//                                    .foregroundColor(.secondary)
//                            }
//                        }
//                    }
//                }
//                if isLoading {
//                    ProgressView()
//                        .progressViewStyle(CircularProgressViewStyle())
//                }
//            }
//            .navigationTitle("Beacons")
//        }
//        .onAppear {
//            beaconManager.startScanning()
//            print("💜 OnAppear")
//        }
//        .onChange(of: beaconManager.beacons.count) { _, newCount in
//            isLoading = newCount < 0
//        }
        
        NavigationStack {
            ZStack {
                List(beaconManager.minewBeacons, id: \.deviceId) { beacon in
                    NavigationLink(value: beacon) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("MAC: \(beacon.mac)")
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
                ToastView(message: "Loading...")
            }
            .navigationDestination(for: MinewBeacon.self) { beacon in
                if
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
