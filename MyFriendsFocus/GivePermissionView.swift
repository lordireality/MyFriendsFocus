//
//  GivePermissionView.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 31.12.2023.
//

import Foundation
import SwiftUI

struct GivePermissionView: View {
    
    let authManager: AuthManager
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(named: "ContactThumbnail") ?? UIImage())
            Text("Для работы приложения, необходимо предоставить доступ к контактам\n\nПриложение не хранит информацию о ваших контактах")
                .multilineTextAlignment(.center)
            Button("Предоставить разрешение", action: authManager.requestAccess)
                .buttonStyle(.bordered)
        }
    }
    
    

}
#Preview(){
    GivePermissionView(authManager: AuthManager())
}
