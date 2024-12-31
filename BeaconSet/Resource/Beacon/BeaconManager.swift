//
//  BeaconManager.swift
//  BeaconSet
//
//  Created by 베스텔라랩 on 12/19/24.
//

import Foundation
import MinewBeaconAdmin
import Combine

class BeaconManager: NSObject, ObservableObject {
    @Published var beacons: [MinewBeacon] = []
    @Published var connectionState: ConnectionState = .disconnected
    
    private var minewBeaconManager: MinewBeaconManager!
    private var currentConnection: MinewBeaconConnection?
    
    override init() {
        super.init()
        setupBeaconManager()
    }
    
    private func setupBeaconManager() {
        minewBeaconManager = MinewBeaconManager.sharedInstance()
        minewBeaconManager.delegate = self
    }
    
    func startScanning() {
        minewBeaconManager.startScan()
    }
    
    func stopScanning() {
        minewBeaconManager.stopScan()
    }
    
    func connect(to beacon: MinewBeacon) {
        // Disconnect existing connection
        disconnect()
        // Create new connection
        currentConnection = MinewBeaconConnection(beacon: beacon)
        currentConnection?.delegate = self
        currentConnection?.connect()
    }
    
    func disconnect() {
        currentConnection?.disconnect()
        currentConnection = nil
    }
}

// MARK: - MinewBeaconManagerDelegate
extension BeaconManager: MinewBeaconManagerDelegate {
    func minewBeaconManager(_ manager: MinewBeaconManager!, didRangeBeacons beacons: [MinewBeacon]!) {
        DispatchQueue.main.async {
            self.beacons = beacons
        }
    }
}

// MARK: - MinewBeaconConnectionDelegate
extension BeaconManager: MinewBeaconConnectionDelegate {
    func beaconConnection(_ connection: MinewBeaconConnection!, didChange state: ConnectionState) {
        DispatchQueue.main.async {
            self.connectionState = state
            
            if state == .connected, let _ = connection.setting {
                print("Connected to Device")
            }
        }
    }
    
    func beaconConnection(_ connection: MinewBeaconConnection!, didWriteSetting success: Bool) {
        DispatchQueue.main.async {
            if success {
                print("Successfully wrote beacon settings")
            } else {
                print("Failed to write beacon settings")
                self.connectionState = .disconnected
                self.currentConnection = nil
            }
        }
    }
}
