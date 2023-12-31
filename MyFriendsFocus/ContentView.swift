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
    let defaults = UserDefaults.standard
    @State var showingFirstLauch:Bool = UserDefaults.standard.bool(forKey: "FirstAppLaunch")
    
    var body: some View {
        HStack{}.sheet(isPresented: $showingFirstLauch, onDismiss: SetFirstLaunchStateFalse){
            WhatsNewView()
        }
        switch authManager.accessGranted {
        case .notDetermined:
            GivePermissionView(authManager: authManager)
        case .restricted:
            AccessDeniedView()
        case .denied:
            AccessDeniedView()
        case .authorized:
            ContactsView(contactManager: ContactManager(store: authManager.store))
        default:
            GivePermissionView(authManager: authManager)
        }


        
    }
    func SetFirstLaunchStateFalse(){
        defaults.set(false, forKey: "FirstAppLaunch")
    }

}
