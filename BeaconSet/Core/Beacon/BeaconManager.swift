//
//  BeaconManager.swift
//  BeaconSet
//
//  Created by 베스텔라랩 on 12/19/24.
//

import Foundation
import CoreLocation
import MinewBeaconAdmin

final class BeaconManager: NSObject, ObservableObject {
    private var locationManager: CLLocationManager?
    private var minewBeaconManager: MinewBeaconManager?
    private var currentConnection: MinewBeaconConnection?
    
    private var minewBeaconStorage: [MinewBeacon]?
    private var CLBeaconStorage: [CLBeacon]?
    
    @Published var beacons: [Beacon] = []
    @Published var connectionState: ConnectionState = .disconnected
    
    override init() {
        super.init()
        setupMinewBeaconManager()
        setupLocationManager()
        setupAppStateMonitoring()
    }
    
    // MinewBeacon Init
    private func setupMinewBeaconManager() {
        self.minewBeaconManager = MinewBeaconManager.sharedInstance()
        self.minewBeaconManager?.delegate = self
    }
    
    // CLLocation Init
    private func setupLocationManager() {
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.requestWhenInUseAuthorization()
    }
}

// MARK: - Beacon Scanning
extension BeaconManager {
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
        print("⏹️ Beacon Stop Scanning")
        // Beacon 배열 제거
        beacons.removeAll()
    }
    
    private func setupAppStateMonitoring() {
        Task {
            // Scene이 Background에 들어갔을 때 동작
            for await _ in AppState.shared.didEnterBackground {
                print("Scene Entered Background")
                await MainActor.run {
                    self.stopScanning()
                }
            }
        }
        
        Task {
            // Scene이 다시 Foreground에 돌아왔을 때 동작
            for await _ in AppState.shared.willEnterForeground {
                print("Scene Entered Foreground")
                await MainActor.run {
                    self.startScanning()
                }
            }
        }
    }
}

// MARK: - Beacon Combining
extension BeaconManager {
    private func combiningBeacons() {
        var beaconDictionary: [BeaconIdentifier: [Beacon]] = [:]
        // MinewBeacon 통합
        minewBeaconStorage?.forEach { minewBeacon in
            let identifier = BeaconIdentifier(major: minewBeacon.major, minor: minewBeacon.minor)
            let beacon = Beacon(from: minewBeacon)
            beaconDictionary[identifier, default: []].append(beacon)
        }
        // CLBeacon 통합 및 UUID 업데이트
        CLBeaconStorage?.forEach { CLBeacon in
            let identifier = BeaconIdentifier(major: CLBeacon.major.intValue, minor: CLBeacon.minor.intValue)
            if var beacons = beaconDictionary[identifier] {
                for index in beacons.indices {
                    beacons[index].uuid = beacons.count > 1 ? "duplicated" : CLBeacon.uuid.uuidString
                }
                beaconDictionary[identifier] = beacons
            }
        }
        
        self.beacons = Array(beaconDictionary.values).flatMap { $0 }.sorted { $0.major < $1.major }
    }
}

extension BeaconManager: MinewBeaconManagerDelegate {
    func minewBeaconManager(_ manager: MinewBeaconManager!, didRangeBeacons beacons: [MinewBeacon]!) {
        minewBeaconStorage = beacons
        print("1️⃣ MinewBeaconScan")
    }
}

extension BeaconManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        CLBeaconStorage = beacons
        combiningBeacons()
        print("2️⃣ CLBeaconScan")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Failed to range beacons: \(error.localizedDescription)")
    }
}

// MARK: - Beacon Connecting
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

// MARK: - Beacon Writing
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
