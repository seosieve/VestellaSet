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
            
            GeometryReader { geometry in
                QRScanner(result: $scannedCode)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .ignoresSafeArea()
            
            GeometryReader { geometry in
                Color.black.opacity(0.6)
                    .mask(
                        Rectangle()
                            .fill(Color.white)
                            .compositingGroup()
                            .luminanceToAlpha()
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: 300, height: 300)
                                    .blendMode(.destinationOut) // 중간 구멍
                                    .position(x: geometry.size.width/2, y: geometry.size.height/2)
                            )
                    )
                    .allowsHitTesting(false)
            }
            .ignoresSafeArea()
            
            VStack {
                Button {
                    store.send(.clickBackButton)
                } label: {
                    Text("Back")
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
