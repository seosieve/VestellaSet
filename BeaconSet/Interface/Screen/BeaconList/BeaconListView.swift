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
                .refreshable {
                    await fetchData()
                }
                .navigationDestination(isPresented: $isConnecting) {
                    beaconDetailView
                }
                .onChange(of: beaconManager.connectionState) { _, newState in
                    handleConnecionState(newState)
                }
        }
    }
}

// MARK: - Configure Views
extension BeaconListView {
    private var mainListView: some View {
        ZStack {
            gradientBackground
            beaconScrollView
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
    
    private var beaconScrollView: some View {
        ScrollView {
            VStack(spacing: 12) {
                Spacer().frame(height: 30)
                ForEach(beaconManager.minewBeacons, id: \.deviceId) { beacon in
                    let _ = print("🐨", beacon.rssi)
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
        
//        List(beaconManager.minewBeacons, id: \.deviceId) { beacon in
//            Button {
//                connectToBeacon(beacon)
//            } label: {
//                BeaconCardView(beacon: beacon)
//            }
//        }
    }
    
    private func beaconCardButton(_ beacon: MinewBeacon) -> some View {
        Button(action: { connectToBeacon(beacon) }) {
            BeaconCardView(beacon: beacon)
        }
        .padding(.horizontal, 20)
        .frame(height: 100)
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
            BeaconDetailView(beaconManager: beaconManager, beacon: beacon, isPresented: $isConnecting)
                .onDisappear {
                    isLoading = false
                }
        }
    }
}

// MARK: - Helper Methods
extension BeaconListView {
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
    
    private func fetchData() async {
        // Start Impact Interaction
        let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
        impactGenerator.prepare()
        impactGenerator.impactOccurred()
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        // Success Impact Interaction
        let successGenerator = UINotificationFeedbackGenerator()
        successGenerator.prepare()
        successGenerator.notificationOccurred(.success)
    }
}
