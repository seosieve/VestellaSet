//
//  GeometryQRScanner.swift
//  VestellaSet
//
//  Created by 서충원 on 8/20/25.
//

import SwiftUI

struct GeometryQRScanner: View {
    @State var scannedCode: String
    
    var body: some View {
        GeometryReader { geometry in
            QRScanner(result: $scannedCode)
                .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea()
    }
}

