//
//  BeaconListView.swift
//  BeaconSet
//
//  Created by 베스텔라랩 on 12/30/24.
//

import SwiftUI
import MinewBeaconAdmin

internal struct BeaconListView: View {
    @StateObject internal var beaconManager = BeaconManager()
    @State private var selectedBeacon: MinewBeacon?
    @State private var isLoading = false
    @State private var isConnecting = false
    
    internal var body: some View {
        NavigationStack {
            mainListView
            .navigationTitle("MinewBeacons")
            .onChange(of: beaconManager.connectionState) { _, newState in
                // Connected 완료 되었을 때 Navigating
                handleConnecionState(newState)
            }
        }
    }
}

// MARK: - Configure Views
extension BeaconListView {
    private var mainListView: some View {
        ZStack {
            beaconList
            loadingOverlay
        }
    }
    
    private var beaconList: some View {
        List(beaconManager.minewBeacons, id: \.deviceId) { beacon in
            BeaconListItemView(beacon: beacon)
                .onTapGesture {
                    connectToBeacon(beacon)
                }
        }
        .navigationDestination(isPresented: $isConnecting) {
            detailView
        }
    }
    
    @ViewBuilder
    private var loadingOverlay: some View {
        if isLoading {
            ToastView(message: "Loading...")
        }
    }
    
    @ViewBuilder
    private var detailView: some View {
        if let beacon = selectedBeacon {
            BeaconDetailView(beaconManager: beaconManager, beacon: beacon)
                .onAppear {
                    resetLoadingStates()
                }
        }
    }
}

// MARK: - Helper Method
extension BeaconListView {
    private func connectToBeacon(_ beacon: MinewBeacon) {
        isLoading = true
        selectedBeacon = beacon
        beaconManager.connect(to: beacon)
    }
    
    private func handleConnecionState(_ newState: ConnectionState) {
        if newState == .connected {
            isConnecting = true
        }
    }
    
    private func resetLoadingStates() {
        isLoading = false
        isConnecting = false
    }
}
