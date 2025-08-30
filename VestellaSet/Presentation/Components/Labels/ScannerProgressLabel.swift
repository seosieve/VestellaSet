//
//  ScannerProgressLabel.swift
//  VestellaSet
//
//  Created by 서충원 on 8/21/25.
//

import SwiftUI
import ComposableArchitecture

struct ScannerProgressLabel<S, A>: View where S: ScannerState {
    let store: Store<S, A>
    
    @Environment(\.scannerConfig) var config
    
    var body: some View {
        DottedLabel(text: store.textMessage)
            .font(Manrope.bold(size: 16))
            .position(x: config.center.x, y: config.center.y + config.length / 2 + Spacing.s36)
            .opacity(store.isFinished ? 0 : 1)
            .animation(.easeInOut, value: store.isFinished)
    }
}
