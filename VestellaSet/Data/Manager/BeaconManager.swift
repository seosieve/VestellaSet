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
    
    @Published internal var minewBeacons: [MinewBeacon] = [] // MinewBeacon 배열
    @Published internal var currentConnection: MinewBeaconConnection? // Connection의 실제 객체
    @Published internal var connectionState: ConnectionState = .disconnected // Connection 결과 저장
    @Published internal var currentSetting: MinewBeaconSetting? // Setting의 실제 객체
    
    @Published internal var isBeaconLost: Bool = false
    @Published internal var selectedBeacon: MinewBeacon?
    
    private var notFoundCount = 0
    var targetMacAddress: String?
    
    override internal init() {
        super.init()
        Task {
            setupBluetoothManager()
            setupMinewBeaconManager()
            await setupAppStateMonitoring()
        }
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
    
    private func setupAppStateMonitoring() async {
        for await event in AppState.shared.appStateStream {
            await handleAppStateEvent(event)
        }
    }
    
    private func handleAppStateEvent(_ event: AppState.Event) async {
        await MainActor.run {
            switch event {
            case .didEnterBackground:
                stopScanning()
            case .willEnterForeground:
                startScanning()
            }
        }
    }
}

// MARK: - Beacon Scanning
extension BeaconManager {
    internal func startScanningWithReset() {
        stopScanning()
        startScanning()
    }
    
    private func startScanning() {
        guard let minewBeaconManager else { return }
        minewBeaconManager.startScan()
        print("▶️ Beacon Start Scanning")
    }
    
    private func stopScanning() {
        guard let minewBeaconManager else { return }
        minewBeaconManager.stopScan()
        print("⏹️ Beacon Stop Scanning")
        // Beacon 배열 제거
        minewBeacons.removeAll()
    }
}

// MARK: - Beacon Combining
extension BeaconManager: MinewBeaconManagerDelegate {
    public func minewBeaconManager(_ manager: MinewBeaconManager!, didRangeBeacons beacons: [MinewBeacon]!) {
        minewBeacons = beacons
        
        guard let targetMacAddress else { return }
        
        let found = beacons.contains { $0.mac == targetMacAddress }
        selectedBeacon = beacons.filter { $0.mac == targetMacAddress }.first
        
        if found {
            notFoundCount = 0
            isBeaconLost = false
        } else {
            notFoundCount += 1
            if notFoundCount >= 4 {
                isBeaconLost = true
            }
        }
    }
}

// MARK: - Beacon Connecting
extension BeaconManager: MinewBeaconConnectionDelegate {
    internal func connect(to beacon: MinewBeacon) {
        // Create new Connection
        currentConnection = MinewBeaconConnection(beacon: beacon)
        currentConnection?.delegate = self
        currentConnection?.connect()
    }
    
    internal func disconnect() {
        currentConnection?.disconnect()
        currentConnection = nil
        // Reset & Start
        startScanningWithReset()
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
    public func write(item: String, macAddress: String) -> [String] {
        guard let setting = currentConnection?.setting else { return [] }
        let parts = item.split(separator: " ").map { Int(String($0))! }
        let major = parts[0]
        let minor = parts[1]
        setting.major = major
        setting.minor = minor
        setting.uuid = SettingRepository.shared.uuid
        setting.broadcastInterval = SettingRepository.shared.broadcastInterval
        setting.txPower = SettingRepository.shared.transmissionPower
        
        print(setting.broadcastInterval)
        currentConnection?.writeSetting(Minew.password)
        print("Write Complete")
        return appendMacAddress(to: item, macAddress: macAddress)
    }
    
    private func appendMacAddress(to item: String, macAddress: String) -> [String] {
        // 1. 기존 배열 불러오기
        var targetList = SettingRepository.shared.targetList
        
        // 2. 특정 item과 일치하는 경우만 뒤에 macAddress 추가
        if let index = targetList.firstIndex(of: item) {
            targetList[index] = "\(targetList[index]) \(macAddress)"
        }
        
        return targetList
    }
    
    public func beaconConnection(_ connection: MinewBeaconConnection!, didWriteSetting success: Bool) {
        if success {
            print("Successfully wrote beacon settings")
            self.connectionState = .disconnected
        } else {
            print("Failed to write beacon settings")
            self.connectionState = .disconnected
            self.currentConnection = nil
        }
    }
}
