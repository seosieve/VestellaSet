//
//  ActionButton.swift
//  VestellaSet
//
//  Created by 서충원 on 8/19/25.
//

import SwiftUI
import ComposableArchitecture

struct ActionButton: View {
    @State var isClicked: Bool = false
    
    var type: ActionInfoType
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
            isClicked = true
        } label: {
            ZStack {
                LoadingDotsView()
                    .opacity(isClicked ? 1 : 0)
                Text(type.title)
                    .font(Manrope.bold(size: 17))
                    .foregroundStyle(Color.mintBlack)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .opacity(isClicked ? 0 : 1)
            }
        }
        .frame(height: 56)
        .background(isClicked ? Color.mintDark : Color.mintBase)
        .cornerRadius(Radius.s8)
        .padding(.horizontal, Spacing.s20)
        .padding(.top, Spacing.s12)
        .padding(.bottom, Spacing.s8)
        .animation(.easeInOut, value: isClicked)
        .disabled(isClicked)
    }
}
