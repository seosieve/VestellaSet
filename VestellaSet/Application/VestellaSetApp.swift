//
//  VestellaSetApp.swift
//  VestellaSet
//
//  Created by 베스텔라랩 on 12/19/24.
//

import SwiftUI
import ComposableArchitecture

@main
internal struct VestellaSetApp: App {
    let store = Store(initialState: AppFeature.State()) { AppFeature() }
    
    internal var body: some Scene {
        WindowGroup {
//            RadarAnimationContainer()
//                .monoBackground()
//                .ignoresSafeArea()
            AppView(store: store)
                .preferredColorScheme(.dark)
        }
    }
}
