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
public let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
struct ContentView: View {
    @StateObject private var authManager = AuthManager()
    let defaults = UserDefaults.standard
    @State var showingFirstLauch:Bool = UserDefaults.standard.bool(forKey: UserDefaults.Keys.FirstAppLaunch.rawValue)
    
    
    init() {
        impactFeedback.prepare()
    }
    
    var body: some View {
        
        //small костыль, что бы в любом случае было отображена вью в случае перерисовок
        HStack{
            if authManager.accessGrantedFocus == .authorized, authManager.accessGrantedContacts == .authorized{
                MainView(authManager: authManager, impactFeedback: impactFeedback)
            } else {
                switch(authManager.accessGrantedContacts, authManager.accessGrantedFocus){
                case (.notDetermined, .notDetermined) :
                    RequestAccessView(viewType: .Both, impactFeedback: impactFeedback)
                case (.notDetermined, .authorized) :
                    RequestAccessView(viewType: .Contacts, impactFeedback: impactFeedback)
                case (.authorized, .notDetermined) :
                    RequestAccessView(viewType: .Focus, impactFeedback: impactFeedback)
                default: AccessDeniedView()
                }
            }
        }
        .sheet(isPresented: $showingFirstLauch, onDismiss: SetFirstLaunchStateFalse){
            WhatsNewView(impactFeedback: impactFeedback)
                .presentationDragIndicator(.visible)
        }
        
    }
    func SetFirstLaunchStateFalse(){
        defaults.set(false, forKey: UserDefaults.Keys.FirstAppLaunch.rawValue)
    }
    private func RequestAccessView(viewType: AccessViewType, impactFeedback: UIImpactFeedbackGenerator) -> some View{
        VStack{
            Text("#ProvidingAccess")
                .font(.headline)
            Text("#ProvidingAccessComment")
            Divider()
            switch(viewType){
            case .Both:
                GivePermissionContactsView(authManager: authManager, impactFeedback: impactFeedback)
                Divider()
                GivePermissionFocusView(authManager: authManager, impactFeedback: impactFeedback)
            case .Contacts:
                GivePermissionContactsView(authManager: authManager, impactFeedback: impactFeedback)
            case .Focus:
                GivePermissionFocusView(authManager: authManager, impactFeedback: impactFeedback)
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
