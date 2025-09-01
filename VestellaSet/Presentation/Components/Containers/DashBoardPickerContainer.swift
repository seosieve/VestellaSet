//
//  DashBoardPickerContainer.swift
//  VestellaSet
//
//  Created by 서충원 on 8/28/25.
//

import SwiftUI
import ComposableArchitecture

struct DashBoardPickerContainer: View {
    let store: StoreOf<BeaconDashBoardFeature>
    
    @State private var selectedIndex: Int = 0
    
    private let options = DashBoardOptionType.allCases
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                // 배경 이동
                RoundedRectangle(cornerRadius: Radius.s8)
                    .fill(Color.mintBase)
                    .frame(width: geo.size.width / CGFloat(options.count), height: 32)
                    .offset(x: CGFloat(selectedIndex) * (geo.size.width / CGFloat(options.count)))
                    .animation(.spring(response: 0.3, dampingFraction: 0.8), value: selectedIndex)
                    .shadow(color: .mintBase, radius: Radius.s32, x: 0, y: 0)
                
                HStack(spacing: 0) {
                    ForEach(Array(options.enumerated()), id: \.offset) { index, option in
                        Text(option.title)
                            .font(store.option == option ? Manrope.bold(size: 14) : Manrope.regular(size: 14))
                            .foregroundColor(selectedIndex == index ? .mintShadow : .monoBase)
                            .frame(maxWidth: .infinity)
                            .frame(height: 32)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedIndex = index
                                store.send(.changeOption(option))
                            }
                    }
                }
            }
            .frame(height: geo.size.height)
        }
        .frame(height: 46)
        .padding(.horizontal, Spacing.s8)
        .glassDashBoardPickerStyle()
        .padding(.horizontal, Spacing.s20)
        .padding(.vertical, Spacing.s12)
    }
}
