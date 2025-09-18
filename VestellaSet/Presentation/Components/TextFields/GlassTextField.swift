//
//  GlassTextField.swift
//  VestellaSet
//
//  Created by 베스텔라랩 on 8/26/25.
//

import SwiftUI

struct GlassTextField: View {
    let type: SettingInfoType
    
    @State var uuid: String = ""
    
    var body: some View {
        HStack {
            Text(type.title)
                .foregroundStyle(Color.monoBase)
                .font(Manrope.regular(size: 15))
            Spacer()
            TextField("", text: $uuid)
                .font(Manrope.bold(size: 16))
                .frame(alignment: .trailing)
                .lineLimit(1)
                .truncationMode(.tail)
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: 52)
        .glassActionButtonStyle()
        .padding(.horizontal, Spacing.s20)
    }
}
