//
//  AppPath.swift
//  VestellaSet
//
//  Created by 서충원 on 8/17/25.
//

import Foundation

enum AppPath: Hashable {
    case beaconImport
    case beaconConfig
    case beaconScanner
    case beaconEditor
}

enum AppPathAction {
    case beaconImport(BeaconImportFeature.Action)
    case beaconConfig(BeaconSettingFeature.Action)
    case beaconScanner(BeaconScannerFeature.Action)
    case beaconEditor(BeaconEditorFeature.Action)
}
