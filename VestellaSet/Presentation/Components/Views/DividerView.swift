//
//  DividerView.swift
//  VestellaSet
//
//  Created by 서충원 on 9/2/25.
//

import SwiftUI

struct DividerView: View {
    let length: CGFloat
    
    var body: some View {
        Capsule()
            .fill(Color.monoDark)
            .frame(width: 1, height: length)
    }
}
