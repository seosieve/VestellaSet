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
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: Radius.s8)
                    .fill(Color.mintBase)
                    .frame(width: geometry.size.width / CGFloat(DashBoardOptionType.allCases.count), height: 32)
                    .offset(x: CGFloat(store.option.index) * (geometry.size.width / CGFloat(DashBoardOptionType.allCases.count)))
                    .animation(.spring(response: 0.3, dampingFraction: 0.8), value: store.option.index)
                    .shadow(color: .mintBase, radius: Radius.s32, x: 0, y: 0)
                
                HStack(spacing: 0) {
                    ForEach(DashBoardOptionType.allCases, id: \.self) { option in
                        Text(option.title)
                            .font(store.option == option ? Manrope.bold(size: 14) : Manrope.regular(size: 14))
                            .foregroundColor(store.option == option ? .mintShadow : .monoBase)
                            .frame(maxWidth: .infinity)
                            .frame(height: 32)
                            .contentShape(Rectangle())
                            .onTapGesture { store.send(.changeOption(option)) }
                    }
                }
            }
            .frame(height: geometry.size.height)
        }
        .frame(height: 46)
        .padding(.horizontal, Spacing.s8)
        .glassDashBoardPickerStyle()
        .padding(.horizontal, Spacing.s20)
        .padding(.vertical, Spacing.s12)
    }
}
