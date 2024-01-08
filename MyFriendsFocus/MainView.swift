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
    var contactManager: ContactManager
    
    init(authManager: AuthManager){
        _authManager = StateObject(wrappedValue: authManager)
        self.contactManager = ContactManager(store: authManager.store)
    }
    
    
    var body: some View {
        TabView(selection: $activeTab){
             ContactsView(contactManager: contactManager, focusManager: FocusManager(statusCentre: authManager.statusCentre))
                 .tabItem {
                     Label("#Contacts", systemImage: "person")
                 }
                 .tag("ContactsView")
                 
                SettingsView(contactManager: contactManager)
                 .tabItem {
                     Label("#Settings", systemImage: "gear")
                 }
                 .tag("SettingsView")
        }.sensoryFeedback(.selection, trigger: activeTab)
    }
}
