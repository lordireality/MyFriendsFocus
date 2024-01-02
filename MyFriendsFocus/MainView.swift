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
    let impactFeedback: UIImpactFeedbackGenerator
    var body: some View {
        TabView(selection: $activeTab){
             ContactsView(contactManager: ContactManager(store: authManager.store), focusManager: FocusManager(statusCentre: authManager.statusCentre), impactFeedback: impactFeedback)
                 .tabItem {
                     Label("#Contacts", systemImage: "person")
                 }
                 .tag("ContactsView")
                 
             SettingsView(impactFeedback: impactFeedback)
                 .tabItem {
                     Label("#Settings", systemImage: "gear")
                 }
                 .tag("SettingsView")
        }.sensoryFeedback(.selection, trigger: activeTab)
    }
}
