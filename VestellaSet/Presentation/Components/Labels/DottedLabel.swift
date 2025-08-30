//
//  DottedLabel.swift
//  VestellaSet
//
//  Created by 서충원 on 8/30/25.
//

import SwiftUI

struct DottedLabel: View {
    let text: String
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.4)) { _ in
            let dotCount = Int(Date().timeIntervalSinceReferenceDate / 0.4) % 4
            Text(text + String(repeating: ".", count: dotCount))
                .foregroundStyle(Color.monoBase)
        }
    }
}
