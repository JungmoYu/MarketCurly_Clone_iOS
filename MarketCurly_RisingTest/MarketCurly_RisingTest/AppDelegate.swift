//
//  AppDelegate.swift
//  MarketCurly_RisingTest
//
//  Created by Jungmo Yu on 2022/03/19.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //탭바 배경색 변경
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            
            //바꾸고 싶은 색으로 backgroundColor를 설정
            UITabBar.appearance().backgroundColor = .white
            UITabBar.appearance().tintColor = .mainPurple
            
            //탭바 바 색상 UIColor와 일치시키지 않기
            UITabBar.appearance().isTranslucent = false
        }
        
        //네비게이션 바 배경색 변경
        if #available(iOS 15.0, *) {
                        
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            appearance.backgroundColor = .mainPurple
            
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().standardAppearance = appearance
            
            //네비게이션 바 색상 UIColor와 일치시키지 않기
            UINavigationBar.appearance().isTranslucent = false
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


}

