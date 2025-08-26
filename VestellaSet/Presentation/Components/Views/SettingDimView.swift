//
//  SettingDimView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/26/25.
//

import SwiftUI

struct SettingDimView: View {
    let action: () -> Void
    
    var body: some View {
        Color.black.opacity(0.4)
            .ignoresSafeArea()
            .onTapGesture { action() }
            .transition(.opacity)
    }
}
