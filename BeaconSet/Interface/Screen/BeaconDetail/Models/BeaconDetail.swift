//
//  BeaconDetail.swift
//  BeaconSet
//
//  Created by 서충원 on 1/21/25.
//

import Foundation

internal struct BeaconDetail: Identifiable {
    internal let id = UUID()
    internal let title: String
    internal let value: String
}

// MARK: - BeaconDetail Factory
extension MinewBeaconSetting {
    func toBeaconDetails() -> [BeaconDetail] {
        let details: [(title: String, value: String)] = [
            ("Battery", String(battery)),
            ("UUID", uuid),
            ("Major", String(major)),
            ("Minor", String(minor)),
            ("Measured Distance", String(calibratedTxPower)),
            ("Transmission Power", String(txPower)),
            ("Broadcast Interval", String(broadcastInterval)),
            ("MAC Address", mac),
            ("iBeacon Name", name ?? "N/A")
        ]
        
        return details.map { BeaconDetail(title: $0.title, value: $0.value) }
    }
}
