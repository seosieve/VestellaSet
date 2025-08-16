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
    internal var body: some Scene {
        WindowGroup {
            AppView(store: Store(initialState: AppFeature.State(), reducer: { AppFeature() }))
        }
    }
}
