//
//  SettingView.swift
//  VestellaSet
//
//  Created by 서충원 on 1/20/25.
//

import SwiftUI

struct SettingView: View {
    @State private var scannedCode = "아직 스캔 안됨"
    
    var body: some View {
        VStack(alignment: .center) {
            saveButton
            Text("스캔된 코드:")
                .font(.headline)
            Text(scannedCode)
                .foregroundColor(.blue)
                .padding()
            
            Text(beaconCount())
            
            QRScanner(result: $scannedCode)
                .frame(width: 200, height: 200)
        }
        .padding()
    }
}

// MARK: - UI Components
extension SettingView {
    private var saveButton: some View {
        Button {
            let array = decodedScannedCodes()
            SettingRepository.shared.targetList = array
        } label: {
            Text("Save")
                .foregroundColor(.blue)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        }
    }
}

// MARK: - Methods
extension SettingView {
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
    
    func beaconCount() -> String {
        let array = decodedScannedCodes()
        return "\(array.count) 개"
    }
}
