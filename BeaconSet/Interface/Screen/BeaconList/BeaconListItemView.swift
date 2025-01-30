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
        ZStack {
            backgroundRectangle
            contentView
        }
    }
}

// MARK: - Configure Views
extension BeaconListItemView {
    private var backgroundRectangle: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.white.opacity(0.1))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            )
    }
    
    private var contentView: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                Text(beacon.mac)
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer().frame(height: 10)
                
                Text("Subtitle or additional content")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
        }
    }
    
    private var navigateCircle: some View {
        Circle()
            .fill(.white)
            .frame(width: 20, height: 20)
            .padding(8)
    }
}
