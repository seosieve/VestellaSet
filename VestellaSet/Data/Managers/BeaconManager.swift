//
//  BeaconManager.swift
//  VestellaSet
//
//  Created by 베스텔라랩 on 12/19/24.
//

import Foundation
import MinewBeaconAdmin
import CoreBluetooth

final public class BeaconManager: NSObject, ObservableObject {
    private var bluetoothManager: CBCentralManager? // Bluetooth Manager
    private var minewBeaconManager: MinewBeaconManager? // MinewBeacon Manager
    private var currentConnection: MinewBeaconConnection? // Connection의 실제 객체
    
    var identifier: String?
    var onBeaconNotFound: (() -> Void)?
    var onBeaconFound: ((MinewBeacon) -> Void)?
    var onBeaconConnect: ((ConnectionState) -> Void)?
    
    override init() {
        super.init()
        setupBluetoothManager()
        setupMinewBeaconManager()
    }
    
    deinit {
        stopScanning()
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
}

// MARK: - Beacon Scanning
extension BeaconManager {
    func startScanning() {
        guard let minewBeaconManager else { return }
        minewBeaconManager.startScan()
        print("▶️ Beacon Start Scanning")
    }
    
    func stopScanning() {
        guard let minewBeaconManager else { return }
        minewBeaconManager.stopScan()
        print("⏹️ Beacon Stop Scanning")
    }
}

// MARK: - Beacon Combining
extension BeaconManager: MinewBeaconManagerDelegate {
    public func minewBeaconManager(_ manager: MinewBeaconManager!, didRangeBeacons beacons: [MinewBeacon]!) {
        guard let identifier else { return }
        
        // MBeacon, MiniBeacon 분기 처리
        let isMini = identifier.contains(Minew.mini)
        let foundBeacon = beacons.first { isMini ? $0.name == identifier : $0.mac == identifier.lowercased() }
        foundBeacon.map { onBeaconFound?($0) } ?? onBeaconNotFound?()
    }
}

// MARK: - Beacon Connecting
extension BeaconManager: MinewBeaconConnectionDelegate {
    func startConnecting(to beacon: MinewBeacon?) {
        guard let beacon else { return }
        currentConnection = MinewBeaconConnection(beacon: beacon)
        currentConnection?.delegate = self
        currentConnection?.connect()
    }
    
    func disconnect() {
        currentConnection?.disconnect()
        currentConnection = nil
    }
    
    // Connecting 결과를 ConnectionState로 방출
    public func beaconConnection(_ connection: MinewBeaconConnection!, didChange state: ConnectionState) {
        onBeaconConnect?(state)
    }
}

// MARK: - Beacon Writing
extension BeaconManager {
    public func startWritting(target: String, uuid: String, interval: Int, power: Int) {
        guard let setting = currentConnection?.setting else { return }
        
        let target = target.split(separator: " ").compactMap { Int($0) }
        guard target.count == 2 else { return }
        
        (setting.major, setting.minor) = (target[0], target[1])
        (setting.uuid, setting.broadcastInterval, setting.txPower) = (uuid, interval, power)
        
        currentConnection?.writeSetting(Minew.password)
    }
    
    public func beaconConnection(_ connection: MinewBeaconConnection!, didWriteSetting success: Bool) {
        if success {
            print("Successfully wrote beacon settings")
            onBeaconConnect?(.disconnected)
        } else {
            print("Failed to write beacon settings")
            onBeaconConnect?(.disconnected)
            self.currentConnection = nil
        }
    }
}
