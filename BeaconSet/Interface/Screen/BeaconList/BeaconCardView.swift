//
//  BeaconCardView.swift
//  BeaconSet
//
//  Created by 서충원 on 1/15/25.
//

import SwiftUI
import MinewBeaconAdmin

internal struct BeaconCardView: View {
    internal let beacon: MinewBeacon
    
//    internal init(beacon: MinewBeacon) {
//        self.beacon = beacon
//        _rssi = State(initialValue: beacon.rssi * -1 / 100)
//    }
    
    internal var body: some View {
        ZStack {
//            Text("\(beacon)")
            BeaconInfoText(title: "RSSI", value: "\(beacon.rssi)", style: .beaconSubtitle)
            backgroundRectangle
            contentView
//            navigateCircle
        }
        
    }
}

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
        
        

// MARK: - Configure Views
extension BeaconCardView {
    private var backgroundRectangle: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.white.opacity(0.1))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            )
    }
    
    @ViewBuilder
    private var contentView: some View {
        HStack {
            VStack {
//                placeText
                Spacer()
            }
            Spacer()
//            lingChart
        }
//        
//        VStack {
//            Text(beacon.mac)
//                .font(.system(size: 16))
//                .fontWeight(.bold)
//                .foregroundColor(.white)
//            
//            Spacer().frame(height: 10)
//            
//            Text("Subtitle or additional content")
//                .font(.system(size: 12))
//                .foregroundColor(.gray)
//        }
    }
    
//    private var placeText: some View {
//        let _ = print("🐨", beacon.rssi)
//        return Text("안산상공회의소뒤\(beacon.rssi)")
//            .font(.system(size: 12))
//            .foregroundStyle(.red)
//            .padding(5)
//            .background(.white.opacity(0.2))
//            .clipShape(RoundedRectangle(cornerRadius: 8))
//            .overlay(
//                RoundedRectangle(cornerRadius: 8)
//                    .strokeBorder(Color.white.opacity(0.4), lineWidth: 1)
//            )
//            .padding(10)
//    }
    
    private var navigateCircle: some View {
        ZStack(alignment: .bottomTrailing) {
            Circle()
                .strokeBorder(Color.white.opacity(0.1), lineWidth: 1)
                .background(Circle().fill(Color.white.opacity(0.3)))
                .frame(width: 40, height: 40)
                .padding(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
//    private var lingChart: some View {
//        ZStack {
//            // 배경 원
//            Circle()
//                .stroke(.gray.opacity(0.3), lineWidth: 4)
//
//            // 진행 원
//            Circle()
//                .trim(from: 0, to: CGFloat(rssi)) // progress에 따라 원의 일부만 그려짐
//                .stroke(.red, style: StrokeStyle(lineWidth: 4, lineCap: .butt))
//                .rotationEffect(.degrees(-90)) // 시작점 조정 (윗부분부터 시작)
//                .animation(.easeInOut(duration: 10), value: CGFloat(rssi)) // 애니메이션
//
//            // 진행률 텍스트
//            Text("\(Int(CGFloat(rssi) * 100))%")
//                .font(.system(size: 12, weight: .bold))
//                .foregroundColor(.red)
//        }
//        .padding(20)
//        .frame(width: 150, height: 150)
//    }
}
