//
//  AppState.swift
//  BeaconSet
//
//  Created by 서충원 on 1/5/25.
//

import UIKit

final internal class AppState {
    static internal let shared = AppState()
    
    private init() {
        setupNotifications()
    }
    
    private let notification = NotificationCenter.default
    
    private var didEnterBackgroundContinuation: AsyncStream<Void>.Continuation?
    private var willEnterForegroundContinuation: AsyncStream<Void>.Continuation?
    
    lazy internal var didEnterBackground: AsyncStream<Void> = {
        AsyncStream { continuation in
            self.didEnterBackgroundContinuation = continuation
        }
    }()
    
    lazy internal var willEnterForeground: AsyncStream<Void> = {
        AsyncStream { continuation in
            self.willEnterForegroundContinuation = continuation
        }
    }()
    
    private func setupNotifications() {
        let backgroundNotificationName = UIApplication.didEnterBackgroundNotification
        notification.addObserver(self, selector: #selector(handleDidEnterBackground), name: backgroundNotificationName, object: nil)
        
        let foregroundNotificationName = UIApplication.willEnterForegroundNotification
        notification.addObserver(self, selector: #selector(handleWillEnterForeground), name: foregroundNotificationName, object: nil)
    }
    
    @objc private func handleDidEnterBackground() {
        didEnterBackgroundContinuation?.yield()
    }
    
    @objc private func handleWillEnterForeground() {
        willEnterForegroundContinuation?.yield()
    }
}
