//
//  BeaconListView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/15/25.
//

import SwiftUI

struct BeaconListView: View {
    @State var value: [String]
    
    var body: some View {
        List(value, id: \.self) { item in
            NavigationLink(value: item) {
                Text(item)
                    .padding()
            }
        }
    }
}
