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
    
    @Namespace private var animationNamespace
    
    var body: some View {
        GeometryReader { geometry in
            let totalSpacing = Spacing.s8 * 4
            let itemWidth = (geometry.size.width - totalSpacing) / 3
            
            HStack(spacing: Spacing.s8) {
                ForEach(DashBoardOptionType.allCases, id: \.self) { option in
                    ZStack {
                        if store.option == option {
                            RoundedRectangle(cornerRadius: Radius.s8)
                                .fill(Color.mintBase)
                                .matchedGeometryEffect(id: "pickerHighlight", in: animationNamespace)
                                .shadow(color: .mintBase, radius: Radius.s32, x: 0, y: 0)
                        }
                        Text(option.title)
                            .font(store.option == option ? Manrope.bold(size: 14) : Manrope.regular(size: 14))
                            .foregroundColor(store.option == option ? .mintShadow : .monoBase)
                    }
                    .frame(width: itemWidth, height: 32)
                    .contentShape(RoundedRectangle(cornerRadius: Radius.s8))
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: store.option)
                    .onTapGesture { store.send(.changeOption(option)) }
                }
            }
            .frame(height: geometry.size.height)
            .padding(.horizontal, Spacing.s8)
        }
        .frame(height: 48)
        .glassDashBoardPickerStyle()
        .padding(.horizontal, Spacing.s20)
        .padding(.vertical, Spacing.s8)
    }
}
