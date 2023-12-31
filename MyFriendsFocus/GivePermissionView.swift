//
//  GivePermissionView.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 31.12.2023.
//

import Foundation
import SwiftUI

struct GivePermissionContactsView: View {
    
    let authManager: AuthManager
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(named: "ContactThumbnail") ?? UIImage())
            Text("Доступ к контактам")
                .multilineTextAlignment(.center)
            Button("Предоставить разрешение к контактам", action: authManager.requestAccessContacts)
                .buttonStyle(.bordered)
        }
    }
}
struct GivePermissionFocusView: View {
    
    let authManager: AuthManager
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(named: "FocusThumbnail") ?? UIImage())
            Text("Доступ к состоянию фокусировки вашего устройства")
                .multilineTextAlignment(.center)
            Button("Предоставить разрешение к состоянию фокусировки", action: authManager.requestAccessFocus)
                .buttonStyle(.bordered)
        }
    }
}



#Preview(){
    GivePermissionContactsView(authManager: AuthManager())
}
