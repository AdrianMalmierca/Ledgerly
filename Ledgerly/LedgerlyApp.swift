//
//  LedgerlyApp.swift
//  Ledgerly
//
//  Created by Adrián on 16/2/26.
//

import SwiftUI

@main
struct LedgerlyApp: App {
    
    init() {
        NotificationService.shared.requestAuthorization()
        NotificationService.shared.scheduleDailyReminder()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
