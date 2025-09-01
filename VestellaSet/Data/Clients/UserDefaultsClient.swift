//
//  UserDefaultsClient.swift
//  VestellaSet
//
//  Created by 서충원 on 8/24/25.
//

import ComposableArchitecture

struct UserDefaultsClient {
    var uuid: () -> String
    var setUuid: (String) -> Void
    var broadcastInterval: () -> Int
    var setBroadcastInterval: (Int) -> Void
    var transmissionPower: () -> Int
    var setTransmissionPower: (Int) -> Void
    var targetList: () -> [String]
    var setTargetList: ([String]) -> Void
    var completeList: () -> [String: String]
    var appendCompleteList: (String, String) -> Void
    var resetCompleteList: () -> Void
}

extension DependencyValues {
    var userDefaults: UserDefaultsClient {
        get { self[UserDefaultsClientKey.self] }
        set { self[UserDefaultsClientKey.self] = newValue }
    }
}

private enum UserDefaultsClientKey: DependencyKey {
    static let liveValue: UserDefaultsClient = UserDefaultsClient(
        uuid: { UserDefaultsManager.shared.uuid },
        setUuid: { UserDefaultsManager.shared.uuid = $0 },
        broadcastInterval: { UserDefaultsManager.shared.broadcastInterval },
        setBroadcastInterval: { UserDefaultsManager.shared.broadcastInterval = $0 },
        transmissionPower: { UserDefaultsManager.shared.transmissionPower },
        setTransmissionPower: { UserDefaultsManager.shared.transmissionPower = $0 },
        targetList: { UserDefaultsManager.shared.targetList },
        setTargetList: { UserDefaultsManager.shared.targetList = $0 },
        completeList: { UserDefaultsManager.shared.completeList },
        appendCompleteList: { UserDefaultsManager.shared.completeList[$0] = $1 },
        resetCompleteList: { UserDefaultsManager.shared.completeList = [:] },
    )
}
