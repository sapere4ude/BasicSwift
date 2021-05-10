//
//  AppDelegate.swift
//  ch06_Notification
//
//  Created by Kant on 2021/05/08.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 11.0, *) {    // UserNotification 프레임워크를 이용한 로컬 알림 (iOS 10 이상)
            let notiCenter = UNUserNotificationCenter.current()
            notiCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (didAllow, e) in }
            notiCenter.delegate = self
        } else {
            // UILocalNotification 을 사용한 로컬 알림
            let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            
            application.registerUserNotificationSettings(setting)
            
        }
        return true
    }
    
    // MARK:- 앱 실행 도중에 알림 메세지가 도착한 경우
    @available(iOS 11.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // 로컬 알림 등록시 입력한 식별 아이디를 읽어오는 속성
        if notification.request.identifier == "wakeUp" {
            let userInfo = notification.request.content.userInfo    // 사용자가 커스텀으로 정의한 정보를 읽어오는 역할
            print(userInfo["name"]!)
        }
        
        // 알림 배너 띄워주기
        completionHandler([.alert, .badge, .sound])
    }
    
    // MARK:- 사용자가 알림 메세지를 클릭했을 경우
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "wakeUp" {
            let userInfo =  response.notification.request.content.userInfo
            print(userInfo["name"]!)
        }
        
        completionHandler()
    }

    // MARK:- UISceneSession Lifecycle

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
            let setting = application.currentUserNotificationSettings
            guard setting?.types != .none else {
                print("Can't Schedule")
                return
            }
            
            // 로컬 알람 인스턴스 생성
            let noti = UILocalNotification()
            noti.fireDate = Date(timeIntervalSinceNow: 10)
            noti.timeZone = TimeZone.autoupdatingCurrent
            noti.alertBody = "다시 접속하세요"
            noti.alertAction = "학습하기"
            noti.applicationIconBadgeNumber = 3
            noti.soundName = UILocalNotificationDefaultSoundName
            noti.userInfo = ["name":"유재준"]
            
            application.scheduleLocalNotification(noti)
            
        }
    }


}

