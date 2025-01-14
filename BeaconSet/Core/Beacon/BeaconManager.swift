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
    
    private var minewBeaconStorage: [MinewBeacon] = []
    private var CLBeaconStorage: [UUID: [CLBeacon]] = [:]
    
    @Published var beacons: [Beacon] = []
    @Published var minewBeacons: [MinewBeacon] = []
    @Published var connectionState: ConnectionState = .disconnected
    
    override init() {
        super.init()
        setupMinewBeaconManager()
        setupLocationManager()
        setupAppStateMonitoring()
    }
}

// MARK: - Beacon Initializing
extension BeaconManager {
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

// MARK: - Beacon Scanning
extension BeaconManager {
    func startScanning() {
        guard let minewBeaconManager, let locationManager else { return }
        minewBeaconManager.stopScan()
        minewBeaconManager.startScan()
        locationManager.startRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: Vestella.uuid))
        locationManager.startRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: Minew.uuid))
        print("▶️ Beacon Start Scanning")
    }
    
    func stopScanning() {
        // MinewBeacon Connecting을 위해 LocationManager Ranging만 중단
        guard let locationManager else { return }
        locationManager.stopRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: Vestella.uuid))
        locationManager.stopRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: Minew.uuid))
        print("⏹️ Beacon Stop Scanning")
        // Beacon 배열 제거
        beacons.removeAll()
    }
}

// MARK: - Beacon Combining
extension BeaconManager: MinewBeaconManagerDelegate, CLLocationManagerDelegate {
    private func combiningBeacons() {
        var beaconDictionary: [BeaconIdentifier: [Beacon]] = [:]
        // MinewBeacon 통합
        minewBeaconStorage.forEach { minewBeacon in
            let identifier = BeaconIdentifier(major: minewBeacon.major, minor: minewBeacon.minor)
            let beacon = Beacon(from: minewBeacon)
            beaconDictionary[identifier, default: []].append(beacon)
        }
        // CLBeacon 통합 및 UUID 업데이트
        for (uuid, beacons) in CLBeaconStorage {
            beacons.forEach { beacon in
                let identifier = BeaconIdentifier(major: beacon.major.intValue, minor: beacon.minor.intValue)
                if var existingBeacons = beaconDictionary[identifier] {
                    for index in existingBeacons.indices {
                        existingBeacons[index].uuid = existingBeacons.count > 1 ? "duplicated" : uuid.uuidString
                    }
                    beaconDictionary[identifier] = existingBeacons
                }
            }
        }
        
        self.beacons = beaconDictionary.flatMap { $0.value }
    }
    
    internal func minewBeaconManager(_ manager: MinewBeaconManager!, didRangeBeacons beacons: [MinewBeacon]!) {
        minewBeaconStorage = beacons
        minewBeacons = beacons
        print("1️⃣ MinewBeaconScan")
    }
    
    internal func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        CLBeaconStorage[beaconConstraint.uuid] = beacons
        // 중복 Update 방지를 위해 Vestella UUID일 때만 Combining
        if beaconConstraint.uuid == Vestella.uuid { combiningBeacons() }
        print("2️⃣ CLBeaconScan")
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Failed to range beacons: \(error.localizedDescription)")
    }
}

// MARK: - Beacon Connecting
extension BeaconManager: MinewBeaconConnectionDelegate {
    func connect(to beacon: MinewBeacon) {
        disconnect()
        // Create new connection
        currentConnection = MinewBeaconConnection(beacon: beacon)
        currentConnection?.delegate = self
        connectionState = .connecting
        
        currentConnection?.connect()
        print("Connecting to beacon...")
    }
    
    func disconnect() {
        currentConnection?.disconnect()
        currentConnection = nil
        connectionState = .disconnected
        print("Disconnected")
    }
    
    func beaconConnection(_ connection: MinewBeaconConnection!, didChange state: ConnectionState) {
        DispatchQueue.main.async {
            self.connectionState = state
            
            switch state {
            case .connected:
                print("Connected to Device and Reading Setting")
            case .disconnected:
                print("Device Disconnected")
            case .connecting:
                print("Connecting to Device")
            case .connectFailed:
                print("Connecting failed")
            @unknown default:
                break
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
}

// MARK: - Beacon Writing
extension BeaconManager {
    func read() {
        guard let setting = currentConnection?.setting else { return }
        print(setting.broadcastInterval)
    }
    
    func write() {
        guard let setting = currentConnection?.setting else { return }
        setting.major = 20
        setting.minor = 10
        setting.broadcastInterval = 3
        print(setting.broadcastInterval)
        currentConnection?.writeSetting("minew123")
        print("Write Complete")
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
