//
//  BackButton.swift
//  VestellaSet
//
//  Created by 서충원 on 8/21/25.
//

import SwiftUI

struct BackButton: View {
    var action: () -> Void
    
    var body: some View {
        HStack {
            GlassButton(imageName: "XMark") { action() }
            Spacer()
        }
        .padding(.top, 12)
        .padding(.leading, 20)
    }
}

