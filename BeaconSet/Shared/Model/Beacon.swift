//
//  Beacon.swift
//  BeaconSet
//
//  Created by 서충원 on 1/2/25.
//

import Foundation
import CoreLocation

struct Beacon: Identifiable {
    let id: UUID
    var uuid: String?
    let mac: String
    let major: Int
    let minor: Int
    let proximity: CLProximity?
    let accuracy: CLLocationAccuracy?
    let rssi: Int
}

// MinewBeacon을 Beacon으로 변환
extension Beacon {
    init(from minewBeacon: MinewBeacon) {
        self.id = UUID()
        self.uuid = nil
        self.mac = minewBeacon.mac
        self.major = minewBeacon.major
        self.minor = minewBeacon.minor
        self.proximity = nil
        self.accuracy = nil
        self.rssi = minewBeacon.rssi
    }
}
