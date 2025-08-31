//
//  BeaconClient.swift
//  VestellaSet
//
//  Created by 서충원 on 8/30/25.
//

import ComposableArchitecture

struct BeaconClient {
    private var manager: BeaconManager
    var setMacAddress: (String) -> Void
    var startScanning: () -> Void
    var startConnecting: (MinewBeacon?) -> Void
    var startWritting: (String, String, Int, Int) -> Void
    var onBeaconNotFound: AsyncStream<Void>
    var onBeaconFound: AsyncStream<MinewBeacon>
    var onBeaconConnect: AsyncStream<ConnectionState>
    
    init() {
        let manager = BeaconManager()
        self.manager = manager
        self.setMacAddress = { mac in
            manager.macAddress = mac
        }
        self.startScanning = {
            manager.startScanning()
        }
        self.startConnecting = { beacon in
            manager.startConnecting(to: beacon)
        }
        self.startWritting = { (target, uuid, interval, power) in
            manager.startWritting(target: target, uuid: uuid, interval: interval, power: power)
        }
        self.onBeaconNotFound = AsyncStream { continuation in
            manager.onBeaconNotFound = { continuation.yield() }
        }
        self.onBeaconFound = AsyncStream { continuation in
            manager.onBeaconFound = { continuation.yield($0) }
        }
        self.onBeaconConnect = AsyncStream { continuation in
            manager.onBeaconConnect = { continuation.yield($0) }
        }
    }
}
