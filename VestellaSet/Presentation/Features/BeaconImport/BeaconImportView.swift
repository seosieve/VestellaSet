//
//  BeaconImportView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/16/25.
//

import SwiftUI
import ComposableArchitecture

struct BeaconImportView: View {
    let store: StoreOf<BeaconImportFeature>
    
    var body: some View {
        ZStack {
            QRScannerContainer(store: store)
            ScannerDecorateContainer()
            QROverlayContainer(store: store)
            
            VStack {
                BackButton { store.send(.clickBackButton) }
                Spacer()
                SaveButton { store.send(.clickSaveButton) }
                    .opacity(store.isFinished ? 1 : 0)
                    .animation(.easeInOut, value: store.isFinished)
            }
        }
        .navigationBarBackButtonHidden()
    }
}
