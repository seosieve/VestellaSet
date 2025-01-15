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
    
    @State private var selectedBeacon: MinewBeacon?
    @State private var isLoading = false
    @State private var isConnecting = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(beaconManager.minewBeacons, id: \.deviceId) { beacon in
                        Button {
                            selectedBeacon = beacon
                            isLoading = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                isConnecting = true
                            }
                        } label: {
                            BeaconListItemView(beacon: beacon)
                        }
                }
                if isLoading {
                    ToastView(message: "Loading...")
                }
            }
            .navigationDestination(isPresented: $isConnecting) {
                if let beacon = selectedBeacon {
                    BeaconDetailView(beaconManager: beaconManager, beacon: beacon)
                        .onAppear {
                            isLoading = false
                            isConnecting = false
                        }
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
