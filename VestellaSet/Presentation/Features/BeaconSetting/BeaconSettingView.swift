//
//  BeaconSettingView.swift
//  VestellaSet
//
//  Created by 서충원 on 1/20/25.
//

import SwiftUI
import ComposableArchitecture

struct BeaconSettingView: View {
    @State var showPicker: Bool = false
    
    let store: StoreOf<BeaconSettingFeature>
    
    var body: some View {
        ZStack {
            VStack(spacing: Spacing.s24) {
                BackButton { store.send(.clickBackButton) }
                TitleLabel("Setting")
                VStack(spacing: Spacing.s12) {
                    GlassInputButton(type: .uuid(Vestella.uuid), action: {})
                    GlassPickerButton(type: .interval(3), action: { showPicker = true })
                    GlassPickerButton(type: .power(4), action: {})
                }
                ActionButton("Save") {}
                Spacer()
            }
            .blur(radius: showPicker ? 10 : 0)
            .animation(.easeInOut, value: showPicker)
            
            if showPicker {
                SettingPickerContainer(isPresented: $showPicker)
            }
        }
        .monoBackground()
        .navigationBarBackButtonHidden()
    }
}
