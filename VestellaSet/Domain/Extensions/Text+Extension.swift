//
//  Text+Extension.swift
//  VestellaSet
//
//  Created by 서충원 on 9/23/25.
//

import SwiftUI

extension Text {
    static var uuidPlaceholder: Text {
        Text(TextMessage.enterUUID)
            .font(Manrope.regular(size: 16))
            .foregroundColor(.monoDark)
    }
    
    static var keywordPlaceholder: Text {
        Text(TextMessage.enterKeyword)
            .font(Manrope.regular(size: 16))
            .foregroundColor(.monoDark)
    }
}
