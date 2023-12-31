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
            Text("Для работы приложения, необходимо предоставить доступ к контактам\n\nПриложение не хранит информацию о ваших контактах")
                .multilineTextAlignment(.center)
            Button("Предоставить разрешение", action: authManager.requestAccessContacts)
                .buttonStyle(.bordered)
        }
    }
}
struct GivePermissionFocusView: View {
    
    let authManager: AuthManager
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(named: "FocusThumbnail") ?? UIImage())
            Text("Для работы приложения, необходимо предоставить доступ к состоянию фокусировки вашего устройства")
                .multilineTextAlignment(.center)
            Button("Предоставить разрешение", action: authManager.requestAccessFocus)
                .buttonStyle(.bordered)
        }
    }
}



#Preview(){
    GivePermissionContactsView(authManager: AuthManager())
}
