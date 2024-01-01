//
//  ContentView.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 28.12.2023.
//

import SwiftUI
import Foundation

import Foundation
import SwiftUI

struct ContentView: View {
    @StateObject private var authManager = AuthManager()
    let defaults = UserDefaults.standard
    @State var showingFirstLauch:Bool = UserDefaults.standard.bool(forKey: UserDefaults.Keys.FirstAppLaunch.rawValue)
    var body: some View {
        
        //small костыль, что бы в любом случае было отображена вью в случае перерисовок
        HStack{}
            .sheet(isPresented: $showingFirstLauch, onDismiss: SetFirstLaunchStateFalse){
            WhatsNewView()
        }
        if authManager.accessGrantedFocus == .authorized, authManager.accessGrantedContacts == .authorized{
            MainView(authManager: authManager)
        } else {
            switch(authManager.accessGrantedContacts, authManager.accessGrantedFocus){
                case (.notDetermined, .notDetermined) :
                    RequestAccessView(viewType: .Both)
                case (.notDetermined, .authorized) :
                    RequestAccessView(viewType: .Contacts)
                case (.authorized, .notDetermined) :
                    RequestAccessView(viewType: .Focus)
                default: AccessDeniedView()
            }
        }
    }
    func SetFirstLaunchStateFalse(){
        defaults.set(false, forKey: UserDefaults.Keys.FirstAppLaunch.rawValue)
    }
    private func RequestAccessView(viewType: AccessViewType) -> some View{
        VStack{
            Text("#ProvidingAccess")
                .font(.headline)
            Text("#ProvidingAccessComment")
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
