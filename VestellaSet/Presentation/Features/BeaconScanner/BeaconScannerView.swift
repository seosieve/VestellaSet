//
//  BeaconScannerView.swift
//  VestellaSet
//
//  Created by 서충원 on 8/5/25.
//

import SwiftUI
import ComposableArchitecture

struct BeaconScannerView: View {
    let store: StoreOf<BeaconScannerFeature>
    
    var body: some View {
        ZStack {
            OCRScannerContainer(store: store)
            ScannerDecorateContainer()
            OCROverlayContainer(store: store)
            
            VStack {
                BackButton { store.send(.clickBackButton) }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}
