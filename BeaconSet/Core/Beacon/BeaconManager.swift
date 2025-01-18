//
//  BeaconManager.swift
//  BeaconSet
//
//  Created by 베스텔라랩 on 12/19/24.
//

import Foundation
import CoreLocation
import CoreBluetooth
import MinewBeaconAdmin

final public class BeaconManager: NSObject, ObservableObject {
    private var bluetoothManager: CBCentralManager? // Bluetooth Manager
    private var locationManager: CLLocationManager? // CLBeacon Manager
    private var minewBeaconManager: MinewBeaconManager? // MinewBeacon Manager
    
    private var minewBeaconStorage: [MinewBeacon] = []
    private var CLBeaconStorage: [UUID: [CLBeacon]] = [:]
    
    @Published internal var beacons: [Beacon] = []
    @Published internal var minewBeacons: [MinewBeacon] = []
    
    @Published internal var currentConnection: MinewBeaconConnection? // Connection의 실제 객체
    @Published internal var connectionState: ConnectionState = .disconnected // Connection 결과 저장
    @Published internal var currentSetting: MinewBeaconSetting?
    
    override internal init() {
        super.init()
        setupBluetoothManager()
        setupMinewBeaconManager()
        setupLocationManager()
        setupAppStateMonitoring()
    }
}

// MARK: - Bluetooth Central
extension BeaconManager: CBCentralManagerDelegate {
    // Bluetooth Central Init
    private func setupBluetoothManager() {
        self.bluetoothManager = CBCentralManager()
        self.bluetoothManager?.delegate = self
    }
    
    // Bluetooth setup이 끝난 후, Scanning 시작
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            startScanning()
        }
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
    internal func startScanning() {
        guard let minewBeaconManager, let locationManager else { return }
        minewBeaconManager.startScan()
        locationManager.startRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: Vestella.uuid))
        locationManager.startRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: Minew.uuid))
        print("▶️ Beacon Start Scanning")
    }
    
    internal func stopScanning() {
        guard let minewBeaconManager, let locationManager else { return }
        minewBeaconManager.stopScan()
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
    
    public func minewBeaconManager(_ manager: MinewBeaconManager!, didRangeBeacons beacons: [MinewBeacon]!) {
        minewBeaconStorage = beacons
        minewBeacons = beacons
    }
    
    public func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        CLBeaconStorage[beaconConstraint.uuid] = beacons
        // 중복 Update 방지를 위해 한 번만 Combining
        if beaconConstraint.uuid == Vestella.uuid { combiningBeacons() }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Failed to range beacons: \(error.localizedDescription)")
    }
}

// MARK: - Beacon Connecting
extension BeaconManager: MinewBeaconConnectionDelegate {
    internal func connect(to beacon: MinewBeacon) {
        // Disconnect First
        disconnect()
        // Create new Connection
        currentConnection = MinewBeaconConnection(beacon: beacon)
        currentConnection?.delegate = self
        currentConnection?.connect()
    }
    
    internal func disconnect() {
        currentConnection?.disconnect()
        currentConnection = nil
    }
    
    // Connecting 결과를 ConnectionState로 방출
    public func beaconConnection(_ connection: MinewBeaconConnection!, didChange state: ConnectionState) {
        self.connectionState = state
        // 연결 되었을 때, Setting값 전달
        if state == .connected {
            self.currentSetting = connection.setting
        }
        
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

// MARK: - Beacon Writing
extension BeaconManager {
    public func read() {
        guard let setting = currentConnection?.setting else { return }
        
        print("Battery: \(setting.battery)")
        print("UUID: \(String(describing: setting.uuid))")
        print("Major: \(setting.major)")
        print("Minor: \(setting.minor)")
        print("Measured Distance: \(String(describing: setting.calibratedTxPower))")
        print("Transmission Power: \(setting.txPower)")
        print("Broadcast Interval: \(setting.broadcastInterval)")
        print("MAC Adress: \(setting.mac ?? "")")
        print("iBeacon Name: \(setting.name ?? "")")
    }
    
    public func write() {
        guard let setting = currentConnection?.setting else { return }
        setting.major = 999
        setting.minor = 999
        setting.broadcastInterval = 3
        print(setting.broadcastInterval)
        currentConnection?.writeSetting("minew123")
        print("Write Complete")
    }
    
    public func beaconConnection(_ connection: MinewBeaconConnection!, didWriteSetting success: Bool) {
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
