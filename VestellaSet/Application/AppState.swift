//
//  AppState.swift
//  BeaconSet
//
//  Created by 서충원 on 1/5/25.
//

import UIKit

final internal class AppState {
    static internal let shared = AppState()
    
    private init() { }
    
    private let notification: NotificationCenter = NotificationCenter.default
    
    internal enum Event {
        case didEnterBackground
        case willEnterForeground
    }
    
    internal var appStateStream: AsyncStream<Event> {
        AsyncStream { continuation in
            let foregroundNotificationName = UIApplication.willEnterForegroundNotification
            let foregroundObserver = notification.addObserver(forName: foregroundNotificationName, object: nil, queue: nil) { _ in
                continuation.yield(.willEnterForeground)
            }
            
            let backgroundNotificationName = UIApplication.didEnterBackgroundNotification
            let backgroundObserver = notification.addObserver(forName: backgroundNotificationName, object: nil, queue: nil) { _ in
                continuation.yield(.didEnterBackground)
            }
            
            continuation.onTermination = { _ in
                self.notification.removeObserver(foregroundObserver)
                self.notification.removeObserver(backgroundObserver)
            }
        }
    }
}
