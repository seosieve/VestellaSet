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
    
    @State private var scannedCode = "아직 스캔 안됨"
    
    var body: some View {
        ZStack {
            GeometryQRScanner(scannedCode: scannedCode)
            ScannerDimView()
            
            VStack {
                GlassButton(imageName: "XMark") {
                    store.send(.clickBackButton)
                }
                Spacer()
                ActionButton(title: "Save") {
                    print("버튼 눌림")
                }
            }
        }
        .monoBackground()
        .navigationBarBackButtonHidden()
        
        
//        Button {
//            store.send(.clickBackButton)
//        } label: {
//            Text("Back")
//        }
//        QRScanner(result: $scannedCode)
//            .frame(width: 200, height: 200)
//        Text("BeaconImportView")
//            
//        ActionButton(title: "Save") {
//            print("버튼 눌림")
//        }
    }
}
