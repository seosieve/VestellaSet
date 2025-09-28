//
//  BeaconSettingView.swift
//  VestellaSet
//
//  Created by 서충원 on 1/20/25.
//

import SwiftUI
import ComposableArchitecture

struct BeaconSettingView: View {
    let store: StoreOf<BeaconSettingFeature>
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: Spacing.s12) {
                    BackButton { store.send(.clickBackButton) }
                    SettingTitleLabel()
                    GlassTextField(store: store, isFocused: $isFocused)
                    GlassSelectionButton(type: .interval(store.interval)) { isFocused = false; store.send(.showSheet(.interval))}
                    GlassSelectionButton(type: .power(store.power)) { isFocused = false; store.send(.showSheet(.power))}
                    SaveSettingButton(store: store) { store.send(.clickSaveButton) }
                    Spacer()
                }
                .blur(radius: store.isSheetPresented ? Radius.s8 : Radius.zero)
                .animation(.easeOut, value: store.isSheetPresented)
                
                SettingSheetContainer(store: store)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .monoBackground()
            .navigationBarBackButtonHidden()
            .onAppear { store.send(.onAppear) }
            .onTapGesture { isFocused = false }
        }
        .ignoresSafeArea(.keyboard)
    }
}
