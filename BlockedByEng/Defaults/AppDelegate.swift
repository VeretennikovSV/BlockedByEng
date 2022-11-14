//
//  AppDelegate.swift
//  BlockedByEng
//
//  Created by Сергей Веретенников on 13/11/2022.
//

import UIKit
import UserNotifications
import AVFoundation

@main
class AppDelegate: UIResponder {

    let notifCenter = UNUserNotificationCenter.current()
    let audioSession = AVAudioPlayer()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        notifCenter.requestAuthorization(options: [.sound, .alert, .badge]) { truee, error in
            guard truee else { return }
            
            self.notifCenter.getNotificationSettings { settings in
                guard settings.authorizationStatus == .authorized else { return }  
            }
        }
        
        application.delegate = self
        
        addNot()
        UIApplication.shared.registerForRemoteNotifications()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    }

    func addNot() {
        
        let content = UNMutableNotificationContent()
        content.sound = .default
        content.title = "Awake!"
        content.body = "UP"
        
        let trig = UNTimeIntervalNotificationTrigger(timeInterval: 3600, repeats: true)
        
        let request = UNNotificationRequest(identifier: "Awake", content: content, trigger: trig)

        notifCenter.add(request) { error in
            print(error)
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate, UIApplicationDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .badge, .banner])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(123)
    }
    
}
