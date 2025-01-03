//
//  DetailView.swift
//  BeaconSet
//
//  Created by 서충원 on 12/31/24.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var beaconManager: BeaconManager
    
    let beacon: Beacon
    
    var body: some View {
        List {
//            Section("Beacon Information") {
//                HStack {
//                    Text("MAC")
//                    Spacer()
//                    Text(beacon.mac)
//                }
//                HStack {
//                    Text("UUID")
//                    Spacer()
//                    Text(beaconManager.uuid ?? "")
//                }
//                HStack {
//                    Text("RSSI")
//                    Spacer()
//                    Text("\(beacon.rssi)")
//                }
//                Button("write") {
//                    beaconManager.write()
//                }
//            }
        }
        .navigationTitle("Beacon Details")
        .onAppear {
//            beaconManager.connect(to: beacon)
        }
    }
}
