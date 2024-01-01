//
//  MainView.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 01.01.2024.
//

import Foundation
import SwiftUI
struct MainView: View {
    @StateObject var authManager = AuthManager()
    var body: some View {
         TabView{
             ContactsView(contactManager: ContactManager(store: authManager.store), focusManager: FocusManager(statusCentre: authManager.statusCentre))
                 .tabItem {
                     Label("Контакты", systemImage: "person")
                 }
             SettingsView()
                 .tabItem {
                     Label("Настройки", systemImage: "gear")
                 }
         }
    }
}
