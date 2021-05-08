//
//  AppDelegate.swift
//  ch06_Notification
//
//  Created by Kant on 2021/05/08.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 10.0, *) {    // UserNotification 프레임워크를 이용한 로컬 알림 (iOS 10 이상)
            let notiCenter = UNUserNotificationCenter.current()
            notiCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (didAllow, e) in }
        } else {
            
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        if #available(iOS 10.0, *) {
            // 알림 동의 여부 확인
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus == .authorized {
                    // step1. 발송 정의
                    let nContent = UNMutableNotificationContent()
                    nContent.badge = 1
                    nContent.title = "로컬 알림 메세지"
                    nContent.subtitle = "얼른 다시 앱을 열어주세요"
                    nContent.body = "어서 들어오세요!"
                    nContent.sound = UNNotificationSound.default
                    nContent.userInfo = ["name":"유재준"]
                    
                    // step2. 알림 시간 정의
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
                    
                    // step3. 알림 요청
                    let request = UNNotificationRequest(identifier: "wakeUp", content: nContent, trigger: trigger)
                    
                    // step4. 노티피케이션 센터 추가
                    UNUserNotificationCenter.current().add(request)
                }
                else {
                    print("사용자가 동의하지 않았습니다.")
                }
            }
        } else {
            // UILocalNotification 객체를 이용한 로컬 알림 (iOS 9 이하)
        }
    }


}

