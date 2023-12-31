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
        //TODO: MAKE UNIVERSAL VIEW FOR TEXT AND DIVIDER!
        switch (authManager.accessGrantedContacts, authManager.accessGrantedFocus) {
        case (.notDetermined, .notDetermined) :
            VStack{
                Text("Предоставление доступа: ")
                    .font(.headline)
                Divider()
                GivePermissionContactsView(authManager: authManager)
                GivePermissionFocusView(authManager: authManager)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        case (.notDetermined, .authorized) :
            VStack{
                Text("Предоставление доступа: ")
                    .font(.headline)
                Divider()
                GivePermissionContactsView(authManager: authManager)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
        case (.authorized, .notDetermined) :
            VStack{
                Text("Предоставление доступа: ")
                    .font(.headline)
                Divider()
                GivePermissionFocusView(authManager: authManager)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        case (.restricted, .restricted),
            (.denied, .denied),
            (.restricted, .denied),
            (.denied, .restricted),
            (.restricted, .authorized),
            (.denied, .authorized),
            (.authorized, .denied),
            (.authorized, .restricted):
            //war crime commited
            AccessDeniedView()
        case (.authorized, .authorized):
            ContactsView(contactManager: ContactManager(store: authManager.store), focusManager: FocusManager(statusCentre: authManager.statusCentre))
        default:
            GivePermissionContactsView(authManager: authManager)
        }
        
    }


}
