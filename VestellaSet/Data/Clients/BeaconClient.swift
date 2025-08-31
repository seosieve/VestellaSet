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
    var stopScanning: () -> Void
    var startConnecting: (MinewBeacon) -> Void
    var startWritting: () -> Void
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
        self.stopScanning = {
            manager.stopScanning()
        }
        self.startConnecting = { beacon in
            manager.startConnecting(to: beacon)
        }
        self.startWritting = {
            manager.startWritting()
        }
        self.onBeaconNotFound = AsyncStream { continuation in
            manager.onBeaconNotFound = {
                continuation.yield()
            }
        }
        self.onBeaconFound = AsyncStream { continuation in
            manager.onBeaconFound = { beacon in
                continuation.yield(beacon)
            }
        }
        self.onBeaconConnect = AsyncStream { continuation in
            manager.onBeaconConnect = { beacon in
                continuation.yield(beacon)
            }
        }
    }
}
