//
//  AppDelegate.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 31.12.2023.
//

import Foundation
import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        if UserDefaults.standard.string(forKey: UserDefaults.Keys.FirstAppLaunch.rawValue) == nil {
            UserDefaults.standard.set(true, forKey: UserDefaults.Keys.FirstAppLaunch.rawValue)
        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {

    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}
