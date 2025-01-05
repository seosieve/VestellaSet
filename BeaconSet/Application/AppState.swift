//
//  AppState.swift
//  BeaconSet
//
//  Created by 서충원 on 1/5/25.
//

import UIKit

final class AppState {
    static let shared = AppState()
    
    private init() { }
    
    private static let notification = NotificationCenter.default

    let didEnterBackground = notification.publisher(for: UIApplication.didEnterBackgroundNotification)
    
    let willEnterForeground = notification.publisher(for: UIApplication.willEnterForegroundNotification)
}
