//
//  View+Extension.swift
//  VestellaSet
//
//  Created by 서충원 on 8/19/25.
//

import SwiftUI

extension View {
    func monoBackground() -> some View {
        self.background(Color.monoBlack.ignoresSafeArea())
    }
    
    func glassActionButtonStyle() -> some View {
        self.modifier(GlassActionButtonModifier())
    }
    
    func glassDashBoardPickerStyle() -> some View {
        self.modifier(GlassDashBoardPickerModifier())
    }
    
    func glassIconButtonStyle() -> some View {
        self.modifier(GlassIconButtonModifier())
    }
    
    func glassSettingSheetStyle() -> some View {
        self.modifier(GlassSettingSheetModifier())
    }
    
    func glassBeaconInfoStyle() -> some View {
        self.modifier(GlassBeaconInfoModifier())
    }
}
