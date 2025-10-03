//
//  TargetInfoButton.swift
//  VestellaSet
//
//  Created by 서충원 on 10/1/25.
//

import SwiftUI

struct TargetInfoButton: View {
    var body: some View {
        Menu {
            Text("Test")
            Text("Test")
            Text("Test")
        } label: {
            ZStack {
                Image.infoIcon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundStyle(Color.monoWhite)
                    .padding(.vertical, 10)
            }
            .frame(width: 60, height: 40)
        }
        .glassIconButtonStyle()
        .padding(.top, Spacing.s12)
        .padding(.trailing, Spacing.s20)
    }
}
