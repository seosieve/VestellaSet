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
    var increaseTimeoutCounter: () -> AsyncStream<Void>
    
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
        self.increaseTimeoutCounter = {
            AsyncStream { continuation in
                manager.increaseTimeoutCounter = {
                    continuation.yield()
                }
            }
        }
    }
}
