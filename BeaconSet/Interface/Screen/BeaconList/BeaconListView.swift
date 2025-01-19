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
            VStack(spacing: 0) {
                filterList
                beaconList
            }
            loadingOverlay
        }
    }
    
    private var filterList: some View {
        HStack {
            Spacer()
            ForEach(0..<3) { _ in
                Button {
                    print("aa")
                } label: {
                    Text("필터버튼")
                        .font(.system(size: 14))
                        .foregroundStyle(.black)
                        .padding(10)
                        .background(Color(UIColor.systemGroupedBackground))
                        .cornerRadius(8)
                }
            }
        }
        .padding()
    }
    
    private var beaconList: some View {
        List(beaconManager.minewBeacons, id: \.deviceId) { beacon in
            Button {
                connectToBeacon(beacon)
            } label: {
                BeaconListItemView(beacon: beacon)
            }
        }
        .navigationDestination(isPresented: $isConnecting) {
            beaconDetailView
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
            BeaconDetailView(beaconManager: beaconManager, beacon: beacon)
                .onDisappear {
                    isLoading = false
                }
        }
    }
}

// MARK: - Helper Methods
extension BeaconListView {
    private func connectToBeacon(_ beacon: MinewBeacon) {
        isLoading = true
        selectedBeacon = beacon
        beaconManager.connect(to: beacon)
    }
    
    private func handleConnecionState(_ newState: ConnectionState) {
        if newState == .connected {
            isConnecting = true
            // Navigation Push Animation이 끝난 후 LoadingView 제거
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isLoading = false
            }
        }
    }
}
