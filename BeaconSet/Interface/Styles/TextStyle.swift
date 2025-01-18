//
//  TextStyle.swift
//  BeaconSet
//
//  Created by 서충원 on 1/15/25.
//

import SwiftUI

internal enum Style {
    case beaconTitle
    case beaconSubtitle
}

internal struct TextStyle: ViewModifier {
    internal let style: Style
    
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

extension View {
    internal func style(_ style: Style) -> some View {
        modifier(TextStyle(style: style))
    }
}
