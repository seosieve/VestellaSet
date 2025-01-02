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
    let uuid: UUID
    let major: NSNumber
    let minor: NSNumber
    let proximity: CLProximity
    let accuracy: CLLocationAccuracy
    let rssi: Int
}

// CLBeacon을 Beacon으로 변환
extension Beacon {
    init(from clBeacon: CLBeacon) {
        self.id = UUID()
        self.uuid = clBeacon.uuid
        self.major = clBeacon.major
        self.minor = clBeacon.minor
        self.proximity = clBeacon.proximity
        self.accuracy = clBeacon.accuracy
        self.rssi = clBeacon.rssi
    }
}
