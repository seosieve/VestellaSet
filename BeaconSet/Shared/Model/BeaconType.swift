//
//  BeaconType.swift
//  BeaconSet
//
//  Created by 서충원 on 1/9/25.
//

import Foundation
import CoreLocation

protocol BeaconType: Hashable {
    var beaconIdentifier: UUID { get }
    var beaconMajor: Int { get }
    var beaconMinor: Int { get }
    var beaconRssi: Int { get }
}

extension BeaconType {
    var beaconIdentifier: UUID {
        return UUID()
    }
    
    // Default implementation for Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(beaconIdentifier)
        hasher.combine(beaconMajor)
        hasher.combine(beaconMinor)
        hasher.combine(beaconRssi)
    }
    
    // Default implementation for Equatable (required by Hashable)
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.beaconIdentifier == rhs.beaconIdentifier &&
        lhs.beaconMajor == rhs.beaconMajor &&
        lhs.beaconMinor == rhs.beaconMinor &&
        lhs.beaconRssi == rhs.beaconRssi
    }
}

extension MinewBeacon: BeaconType {
    var beaconMajor: Int {
        return self.major
    }
    
    var beaconMinor: Int {
        return self.minor
    }
    
    var beaconRssi: Int {
        return self.rssi
    }
}

extension CLBeacon: BeaconType {
    var beaconMajor: Int {
        return Int(truncating: self.major)
    }
    
    var beaconMinor: Int {
        return Int(truncating: self.minor)
    }
    
    var beaconRssi: Int {
        return self.rssi
    }
}
