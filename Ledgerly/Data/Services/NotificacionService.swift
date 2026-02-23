//
//  NotificacionService.swift
//  Ledgerly
//
//  Created by Adrián on 23/2/26.
//

import Foundation
import UserNotifications

final class NotificationService {
    
    static let shared = NotificationService()
    
    private init() {}
    
    // Solicitar permiso
    func requestAuthorization() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if let error = error {
                    print("Error requesting authorization: \(error)")
                }
                print("Permission granted: \(granted)")
            }
    }
    
    // Programar recordatorio diario
    func scheduleDailyReminder(at hour: Int = 20) {
        let content = UNMutableNotificationContent()
        content.title = "No olvides tus gastos"
        content.body = "Registra tus gastos del día para mantener tu presupuesto actualizado."
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )
        
        let request = UNNotificationRequest(
            identifier: "dailyExpenseReminder",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
}
