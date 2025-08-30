//
//  UserDefaultsClient.swift
//  VestellaSet
//
//  Created by 서충원 on 8/24/25.
//

import ComposableArchitecture

struct UserDefaultsClient {
    var getBroadcastInterval: () -> Int
    var setBroadcastInterval: (Int) -> Void
    var getTransmissionPower: () -> Int
    var setTransmissionPower: (Int) -> Void
    var getTargetList: () -> [String]
    var setTargetList: ([String]) -> Void
}

extension DependencyValues {
    var userDefaultsClient: UserDefaultsClient {
        get { self[UserDefaultsClientKey.self] }
        set { self[UserDefaultsClientKey.self] = newValue }
    }
}

private enum UserDefaultsClientKey: DependencyKey {
    static let liveValue: UserDefaultsClient = UserDefaultsClient(
        getBroadcastInterval: { UserDefaults.standard.integer(forKey: UserDefaultsKey.broadcastInterval) },
        setBroadcastInterval: { UserDefaults.standard.set($0, forKey: UserDefaultsKey.broadcastInterval) },
        getTransmissionPower: { UserDefaults.standard.integer(forKey: UserDefaultsKey.transmissionPower) },
        setTransmissionPower: { UserDefaults.standard.set($0, forKey: UserDefaultsKey.transmissionPower) },
        getTargetList: { UserDefaults.standard.stringArray(forKey: UserDefaultsKey.targetList) ?? [] },
        setTargetList: { UserDefaults.standard.set($0, forKey: UserDefaultsKey.targetList) }
    )
}
