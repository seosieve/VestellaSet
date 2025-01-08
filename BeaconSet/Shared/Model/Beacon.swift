//
//  Beacon.swift
//  BeaconSet
//
//  Created by 서충원 on 1/2/25.
//

import Foundation
import CoreLocation

struct Beacon: Hashable, Identifiable {
    let id = UUID()
    var uuid: String?
    let mac: String?
    let major: Int
    let minor: Int
    var proximity: CLProximity?
    var accuracy: CLLocationAccuracy?
    let rssi: Int
    let battery: Int
    var status: BeaconStatus
}

extension Beacon {
    // Duplicate Check
    enum BeaconStatus {
        case normal
        case duplicated
    }
    
    // MinewBeacon을 Beacon으로 변환
    init(from minewBeacon: MinewBeacon, status: BeaconStatus = .normal) {
        self.mac = minewBeacon.mac
        self.major = minewBeacon.major
        self.minor = minewBeacon.minor
        self.rssi = minewBeacon.rssi
        self.battery = minewBeacon.battery
        self.status = status
        
    }
}
