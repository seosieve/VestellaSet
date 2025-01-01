//
//  BeaconManager.swift
//  BeaconSet
//
//  Created by 베스텔라랩 on 12/19/24.
//

import Foundation
import MinewBeaconAdmin

class BeaconManager: NSObject, ObservableObject {
    @Published var beacons: [MinewBeacon] = []
    @Published var connectionState: ConnectionState = .disconnected
    @Published var uuid: String?
    
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
        print("Beacon Start Scanning")
    }
    
    func stopScanning() {
        minewBeaconManager.stopScan()
        beacons.removeAll()
        print("Beacon Stop Scanning")
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
        uuid = nil
    }
    
    func write() {
        guard let connection = currentConnection, connectionState == .connected else {
            print("Cannot write: No active connection")
            return
        }
        
        connection.setting.uuid = "0400e709-2801-4d62-b462-b6aeaf9be556"
        connection.writeSetting("minew123")
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
            
            if state == .connected {
                self.uuid = connection.setting.uuid ?? ""
                print("Connected to Device and Reading Setting")
            }
        }
    }
    
    func beaconConnection(_ connection: MinewBeaconConnection!, didReadSetting setting: MinewBeaconSetting!) {
        DispatchQueue.main.async {
            if setting != nil {
                print("Successfully read device settings")
                // Now you can safely access and modify settings
            } else {
                print("Failed to read device settings")
                self.connectionState = .disconnected
                self.currentConnection = nil
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
