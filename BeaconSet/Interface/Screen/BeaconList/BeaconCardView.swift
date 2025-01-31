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
    
    internal var body: some View {
        ZStack {
            backgroundRectangle
            contentView
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
                placeText
                Spacer()
            }
            Spacer()
            lingChart
        }
    }
    
    private var placeText: some View {
        return Text("안산상공회의소뒤\(beacon.rssi)")
            .font(.system(size: 12))
            .foregroundStyle(.red)
            .padding(5)
            .background(.white.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.white.opacity(0.4), lineWidth: 1)
            )
            .padding(10)
    }
    
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
    
    private var lingChart: some View {
        ZStack {
            // 배경 원
            Circle()
                .stroke(.gray.opacity(0.3), lineWidth: 4)

            // 진행 원
            Circle()
                .trim(from: 0, to: CGFloat(beacon.rssi) * -1 / 100) // progress에 따라 원의 일부만 그려짐
            
                .stroke(AngularGradient(gradient: Gradient(colors: [.gray.opacity(0), .red]),
                                        center: .center,
                                        startAngle: .degrees(0),
                                        endAngle: .degrees(CGFloat(CGFloat(CGFloat(beacon.rssi) * -1 / 100) * 360))),style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .rotationEffect(.degrees(-90)) // 시작점 조정 (윗부분부터 시작)

            // 진행률 텍스트
            Text("\(Int(CGFloat(beacon.rssi) * -1 / 100 * 100))%")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.red)
        }
        .padding(20)
        .frame(width: 100, height: 100)
    }
}
