//
//  ListDividerView.swift
//  VestellaSet
//
//  Created by 베스텔라랩 on 9/2/25.
//

import SwiftUI
import ComposableArchitecture

struct ListDividerView: View {
    let count: Int
    let index: Int
    
    var body: some View {
        Rectangle().fill(Color.monoBlack).frame(height: 1)
            .opacity(index == count - 1 ? 0 : 1)
    }
}
