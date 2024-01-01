//
//  ContentView.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 28.12.2023.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @StateObject private var authManager = AuthManager()
    
    var body: some View {
        switch (authManager.accessGrantedContacts, authManager.accessGrantedFocus) {
        case (.notDetermined, .notDetermined) :
            RequestAccessView(viewType: .Both)
        case (.notDetermined, .authorized) :
            RequestAccessView(viewType: .Contacts)
        case (.authorized, .notDetermined) :
            RequestAccessView(viewType: .Focus)
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
            TabView{
                ContactsView(contactManager: ContactManager(store: authManager.store), focusManager: FocusManager(statusCentre: authManager.statusCentre))
                    .tabItem {
                        Label("Контакты", systemImage: "person")
                    }
            }
            
        default:
            GivePermissionContactsView(authManager: authManager)
        }
        
    }
    private func RequestAccessView(viewType: AccessViewType) -> some View{
        VStack{
            Text("Предоставление доступа: ")
                .font(.headline)
            Text("Для работы приложения, необходимо предоставить следующие разрешения:")
            Divider()
            switch(viewType){
                case .Both: 
                GivePermissionContactsView(authManager: authManager)
                Divider()
                GivePermissionFocusView(authManager: authManager)
                case .Contacts:
                GivePermissionContactsView(authManager: authManager)
                case .Focus:
                GivePermissionFocusView(authManager: authManager)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    private enum AccessViewType{
        case Both
        case Contacts
        case Focus
        
    }


}
