//
//  BeaconListItemView.swift
//  BeaconSet
//
//  Created by 서충원 on 1/15/25.
//

import SwiftUI
import MinewBeaconAdmin

internal struct BeaconListItemView: View {
    internal let beacon: MinewBeacon
    
    internal var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            BeaconInfoText(title: "MAC", value: beacon.mac, style: .beaconTitle)
            HStack {
                BeaconInfoText(title: "RSSI", value: "\(beacon.rssi)", style: .beaconSubtitle)
                BeaconInfoText(title: "Major", value: "\(beacon.major)", style: .beaconSubtitle)
                BeaconInfoText(title: "Minor", value: "\(beacon.minor)", style: .beaconSubtitle)
            }
        }
    }
}

private struct BeaconInfoText: View {
    let title: String
    let value: String
    let style: Style
    
    var body: some View {
        Text("\(title): \(value)")
            .style(style)
    }
}
