//
//  BeaconConnectView.swift
//  VestellaSet
//
//  Created by 베스텔라랩 on 12/30/24.
//

import SwiftUI
import MinewBeaconAdmin

internal struct BeaconConnectView: View {
    @StateObject internal var beaconManager = BeaconManager()
    @Binding var path: NavigationPath
    @State private var selectedBeacon: MinewBeacon?
    @State private var isLoading = false
    @State private var isConnecting = false
    @State var macAddress: String
    
    @State private var notFoundCount = 0
    
    @Environment(\.dismiss) private var dismiss
    
    let target: String
    
    internal var body: some View {
        mainListView
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
            .onChange(of: beaconManager.connectionState) { _, newState in
                print("🧊 \(newState)")
                if newState == .connected {
                    print("connected a djkawdjwaodkwoad;lwa")
                    let newData = beaconManager.write(item: target, macAddress: macAddress)
                    SettingRepository.shared.targetList = newData
                }
                if newState == .disconnected {
                    beaconManager.disconnect()
                    path.removeLast(2)
                }
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
            if let selectedBeacon = beaconManager.selectedBeacon {
                BeaconCardView(beacon: selectedBeacon)
                    .id(selectedBeacon.rssi)
                    .padding(.horizontal, 20)
                    .frame(height: 100)
                
                Button {
                    connectToBeacon(selectedBeacon)
                } label: {
                    Text("Write")
                        .background(Color.gray)
                }
            }
        }
    }
    
    @ViewBuilder
    private var loadingOverlay: some View {
        if isLoading {
            LoadingToastView()
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
