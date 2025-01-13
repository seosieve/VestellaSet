//
//  BeaconDetailView.swift
//  BeaconSet
//
//  Created by 서충원 on 12/31/24.
//

import SwiftUI

struct BeaconDetailView: View {
    @ObservedObject var beaconManager: BeaconManager
    
    let beacon: MinewBeacon
    
    var body: some View {
        List {
            HStack {
                Text("TX")
                Spacer()
                Text("\(beacon.txPower)")
                    .font(.system(size: 12))
            }
            HStack {
                Text("UUID")
                Spacer()
                Text(beacon.uuid ?? "")
                    .font(.system(size: 12))
            }
            HStack {
                Text("RSSI")
                Spacer()
                Text("\(beacon.rssi)")
                    .font(.system(size: 12))
            }
            Button("Connect") {
                beaconManager.connect(to: beacon)
            }
            Button("Connect") {
                beaconManager.write()
            }
        }
    }
}
