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

// MARK: - Configure Views
private struct BeaconInfoText: View {
    internal enum Style {
        case beaconTitle
        case beaconSubtitle
    }
    
    let title: String
    let value: String
    let style: Style
    
    var body: some View {
        Text("\(title): \(value)")
            .modifier(BeaconInfoTextStyle(style: style))
    }
}

// MARK: - View Modifiers
private struct BeaconInfoTextStyle: ViewModifier {
    let style: BeaconInfoText.Style
    
    internal func body(content: Content) -> some View {
        switch style {
        case .beaconTitle:
            content
                .foregroundColor(.black)
                .font(.system(size: 12))
        case .beaconSubtitle:
            content
                .foregroundColor(.secondary)
                .font(.subheadline)
        }
    }
}
