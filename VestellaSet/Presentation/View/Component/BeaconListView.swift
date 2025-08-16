//
//  BeaconListView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/15/25.
//

import SwiftUI

struct BeaconListView: View {
    @State var targetList: [String] = []
    
    var body: some View {
        List(targetList, id: \.self) { target in
            NavigationLink(value: Destination.ocrReader(target: target)) {
                Text(target)
                    .padding()
            }
        }
        .onAppear {
            targetList = SettingRepository.shared.targetList
        }
    }
}
