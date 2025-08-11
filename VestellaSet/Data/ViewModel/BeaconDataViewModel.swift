//
//  BeaconDataViewModel.swift
//  VestellaSet
//
//  Created by 서충원 on 8/10/25.
//

import Foundation

class BeaconDataViewModel: ObservableObject {
    @Published var data: [String] = []

    init() {
        load()
    }
    
    func load() {
        if let savedData = UserDefaults.standard.array(forKey: "myApp_beaconList") as? [String] {
            data = savedData
        } else {
            data = []
        }
    }
    
    func save(_ newData: [String]) {
        UserDefaults.standard.set(newData, forKey: "myApp_beaconList")
        data = newData
    }
}
