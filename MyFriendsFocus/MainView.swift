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
    @State var activeTab = "ContactsView"
    var body: some View {
        TabView(selection: $activeTab){
             ContactsView(contactManager: ContactManager(store: authManager.store), focusManager: FocusManager(statusCentre: authManager.statusCentre))
                 .tabItem {
                     Label("#Contacts", systemImage: "person")
                 }
                 .tag("ContactsView")
                 
             SettingsView()
                 .tabItem {
                     Label("#Settings", systemImage: "gear")
                 }
                 .tag("SettingsView")
        }.sensoryFeedback(.selection, trigger: activeTab)
    }
}
