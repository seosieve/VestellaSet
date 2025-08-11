//
//  BeaconSettingView.swift
//  BeaconSet
//
//  Created by 서충원 on 1/20/25.
//

import SwiftUI

struct BeaconSettingView: View {
    @ObservedObject var model: BeaconDataViewModel
    
    @State private var scannedCode = "아직 스캔 안됨"
    
    var body: some View {
        VStack(alignment: .center) {
            saveButton
            Text("스캔된 코드:")
                .font(.headline)
            Text(scannedCode)
                .foregroundColor(.blue)
                .padding()
            
            QRScannerView(scannedCode: $scannedCode)
                .frame(width: 200, height: 200)
        }
        .padding()
    }
}

// MARK: - UI Components
extension BeaconSettingView {
    private var saveButton: some View {
        Button {
            let array = decodedScannedCodes()
            UserDefaults.standard.set(array, forKey: "myApp_beaconList")
            model.save(array)
        } label: {
            Text("Save")
                .foregroundColor(.blue)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        }
    }
}

extension BeaconSettingView {
    func decodedScannedCodes() -> [String] {
        guard let data = scannedCode.data(using: .utf8) else {
            print("scannedCode 문자열을 UTF-8 데이터로 변환 실패")
            return []
        }
        
        do {
            return try JSONDecoder().decode([String].self, from: data)
        } catch {
            print("scannedCode 디코딩 실패: \(error.localizedDescription)")
            return []
        }
    }
}
