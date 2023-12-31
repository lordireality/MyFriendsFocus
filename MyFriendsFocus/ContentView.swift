//
//  ContentView.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 28.12.2023.
//

import SwiftUI
import Foundation

struct ContentView: View {
    //роутинг я пока не проходил, поэтому вью перерисовываются от изменения в менеджере доступа к контактам
    @StateObject private var authManager = AuthManager()
    
    
    var body: some View {
        
        switch authManager.accessGrantedContacts{
        case .notDetermined:
            GivePermissionContactsView(authManager: authManager)
        case .restricted:
            AccessDeniedView()
        case .denied:
            AccessDeniedView()
        case .authorized:
            ContactsView(contactManager: ContactManager(store: authManager.store))
        default:
            GivePermissionContactsView(authManager: authManager)
        }


        
    }


}
