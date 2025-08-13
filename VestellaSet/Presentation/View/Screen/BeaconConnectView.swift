//
//  BeaconConnectView.swift
//  VestellaSet
//
//  Created by 베스텔라랩 on 12/30/24.
//

import SwiftUI
import MinewBeaconAdmin

internal struct BeaconConnectView: View {
    @ObservedObject var model: BeaconDataViewModel
    @StateObject internal var beaconManager = BeaconManager()
    @State private var selectedBeacon: MinewBeacon?
    @State private var isLoading = false
    @State private var isConnecting = false
    @State var macAddress: String
    
    @State private var notFoundCount = 0
    
    @Environment(\.dismiss) private var dismiss
    
    let item: String
    
    internal var body: some View {
        mainListView
            .navigationDestination(isPresented: $isConnecting) {
                beaconDetailView
            }
            .onChange(of: beaconManager.connectionState) { _, newState in
                handleConnecionState(newState)
            }
            .onChange(of: beaconManager.isBeaconLost) { _, lost in
                if lost {
                    dismiss()
                }
            }
            .onAppear {
                print(macAddress)
                beaconManager.targetMacAddress = macAddress
            }
    }
}

// MARK: - Configure Views
extension BeaconConnectView {
    private var mainListView: some View {
        ZStack {
            gradientBackground
            beaconView
            loadingOverlay
        }
    }
    
    private var gradientBackground: some View {
        LinearGradient(
            gradient: Gradient(colors: [.gray.opacity(0.4), .gray.opacity(0.5)]),
            startPoint: .topLeading,
            endPoint: .center
        )
        .ignoresSafeArea()
    }
    
    private var beaconView: some View {
        VStack(spacing: 12) {
            ForEach(beaconManager.minewBeacons.filter { $0.mac == macAddress }, id: \.deviceId) { beacon in
                Button {
                    connectToBeacon(beacon)
                } label: {
                    BeaconCardView(beacon: beacon)
                }
                .id(beacon.rssi)
                .padding(.horizontal, 20)
                .frame(height: 100)
            }
        }
    }
    
    @ViewBuilder
    private var loadingOverlay: some View {
        if isLoading {
            LoadingToastView()
        }
    }
    
    @ViewBuilder
    private var beaconDetailView: some View {
        if let beacon = selectedBeacon {
            BeaconWriteView(model: model, beaconManager: beaconManager, beacon: beacon, item: item, macAddress: macAddress, isPresented: $isConnecting)
                .onDisappear {
                    isLoading = false
                }
        }
    }
}

// MARK: - Helper Methods
extension BeaconConnectView {
    private func handleConnecionState(_ newState: ConnectionState) {
        if newState == .connected {
            isConnecting = true
            // Navigation Push Animation이 끝난 후 LoadingView 제거
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isLoading = false
            }
        }
    }
    
    private func connectToBeacon(_ beacon: MinewBeacon) {
        isLoading = true
        selectedBeacon = beacon
        beaconManager.connect(to: beacon)
    }
}
