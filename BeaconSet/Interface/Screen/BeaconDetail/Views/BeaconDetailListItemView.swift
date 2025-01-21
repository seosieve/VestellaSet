//
//  BeaconDetailListItemView.swift
//  BeaconSet
//
//  Created by 서충원 on 1/21/25.
//

import SwiftUI

struct BeaconDetailListItemView: View {
    internal let detail: BeaconDetail
    
    var body: some View {
        HStack {
            Text(detail.title)
            Spacer()
            Text(detail.value)
                .font(.system(size: 12))
        }
    }
}
