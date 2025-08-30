//
//  BeaconClient.swift
//  VestellaSet
//
//  Created by 서충원 on 8/30/25.
//

import ComposableArchitecture

struct BeaconClient {
    var manager: BeaconManager
    var startScanning: () -> Void
    var stopScanning: () -> Void
}

extension DependencyValues {
    var beaconClient: BeaconClient {
        get { self[BeaconClientKey.self] }
        set { self[BeaconClientKey.self] = newValue }
    }
}

private enum BeaconClientKey: DependencyKey {
    static let liveValue: BeaconClient = {
        let manager = BeaconManager()
        return BeaconClient(
            manager: manager,
            startScanning: { manager.startScanning() },
            stopScanning: { manager.stopScanning() },
        )
    }()
}
