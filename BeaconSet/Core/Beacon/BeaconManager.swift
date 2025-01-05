//
//  BeaconManager.swift
//  BeaconSet
//
//  Created by 베스텔라랩 on 12/19/24.
//

import Foundation
import CoreLocation
import MinewBeaconAdmin

class BeaconManager: NSObject, ObservableObject {
    private var locationManager: CLLocationManager?
    private var minewBeaconManager: MinewBeaconManager?
    private var currentConnection: MinewBeaconConnection?
    
    private var minewBeacons: [Beacon] = []
    @Published var beacons: [Beacon] = []
    @Published var connectionState: ConnectionState = .disconnected
    
    override init() {
        super.init()
        setupMinewBeaconManager()
        setupLocationManager()
    }
    
    private func setupMinewBeaconManager() {
        self.minewBeaconManager = MinewBeaconManager.sharedInstance()
        self.minewBeaconManager?.delegate = self
    }
    
    private func setupLocationManager() {
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.requestWhenInUseAuthorization()
    }
    
    func startScanning() {
        guard let minewBeaconManager, let locationManager else { return }
        minewBeaconManager.startScan()
        locationManager.startRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: Vestella.uuid))
        print("▶️ Beacon Start Scanning")
    }
    
    func stopScanning() {
        guard let minewBeaconManager, let locationManager else { return }
        minewBeaconManager.stopScan()
        locationManager.stopRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: Vestella.uuid))
        beacons.removeAll()
        print("⏯️ Beacon Stop Scanning")
    }
}

// MARK: - Connecting
extension BeaconManager {
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

// MARK: - Writing
extension BeaconManager {
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
        self.minewBeacons = beacons.map { Beacon(from: $0) }
        print("🌱 MinewBeaconScan")
    }
}

// MARK: - CLLocationManagerDelegate
extension BeaconManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        DispatchQueue.main.async {
            beacons.forEach { clBeacon in
                if let index = self.minewBeacons.firstIndex(where: { $0.major == clBeacon.major.intValue && $0.minor == clBeacon.minor.intValue }) {
                    self.minewBeacons[index].uuid = clBeacon.uuid.uuidString
                    self.beacons = self.minewBeacons
                }
            }
            print("🐈 DefaultBeaconScan")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Failed to range beacons: \(error.localizedDescription)")
    }
}

// MARK: - MinewBeaconConnectionDelegate
extension BeaconManager: MinewBeaconConnectionDelegate {
    func beaconConnection(_ connection: MinewBeaconConnection!, didChange state: ConnectionState) {
        DispatchQueue.main.async {
            self.connectionState = state
            
            if state == .connected {
                print("Connected to Device and Reading Setting")
            }
        }
    }
    
    func beaconConnection(_ connection: MinewBeaconConnection!, didReadSetting setting: MinewBeaconSetting!) {
        DispatchQueue.main.async {
            if setting != nil {
                print("Successfully read device settings")
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
