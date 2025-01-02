//
//  DefaultBeaconManager.swift
//  BeaconSet
//
//  Created by 서충원 on 1/2/25.
//

import Foundation
import CoreLocation

class DefaultBeaconManager: NSObject, ObservableObject {
    private var locationManager: CLLocationManager?
    
    private static let uuid = UUID(uuidString: "a0fabefc-b1f5-4836-8328-7c5412fff9c4")!
    private lazy var constraint = CLBeaconIdentityConstraint(uuid: Self.uuid)
    
    @Published var beacons: [Beacon] = []
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.requestWhenInUseAuthorization()
    }
    
    func startScanning() {
        guard let locationManager else { return }
        locationManager.startRangingBeacons(satisfying: constraint)
    }
    
    func stopScanning() {
        guard let locationManager else { return }
        locationManager.stopRangingBeacons(satisfying: constraint)
    }
}

// MARK: - CLLocationManagerDelegate
extension DefaultBeaconManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        DispatchQueue.main.async {
            self.beacons = beacons.map { Beacon(from: $0) }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Failed to range beacons: \(error.localizedDescription)")
    }
}
