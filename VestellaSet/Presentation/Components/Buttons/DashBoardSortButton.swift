//
//  DashBoardSortButton.swift
//  VestellaSet
//
//  Created by 서충원 on 8/28/25.
//

import SwiftUI

struct DashBoardSortButton: View {
    @State private var isCompletedFirst: Bool = true
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: { isCompletedFirst.toggle() }) {
                Text(isCompletedFirst ? "Completed first" : "Incomplete first")
                    .font(Manrope.regular(size: 15))
                    .foregroundStyle(Color.monoMedium)
                Image.sortIcon
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(Color.monoMedium)
            }
        }
        .padding(.horizontal, Spacing.s20)
    }
}

