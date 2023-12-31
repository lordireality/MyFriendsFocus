//
//  MyFriendsFocusApp.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 28.12.2023.
//

import SwiftUI

@main
struct MyFriendsFocusApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let defaults = UserDefaults.standard
    @State var showingFirstLauch:Bool = UserDefaults.standard.bool(forKey: "FirstAppLaunch")
    var body: some Scene {
        WindowGroup {
            ContentView().preferredColorScheme(.dark).sheet(isPresented: $showingFirstLauch, onDismiss: SetFirstLaunchStateFalse){
                WhatsNewView()
            }
        }
    }
    func SetFirstLaunchStateFalse(){
        defaults.set(false, forKey: "FirstAppLaunch")
    }
}
