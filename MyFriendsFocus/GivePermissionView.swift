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
            Text("#ContactsAccess")
                .multilineTextAlignment(.center)
            Button("#ContactGrant"){
                impactFeedback.impactOccurred()
                authManager.requestAccessContacts()
            }
            .buttonStyle(.bordered)
        }
    }
}
struct GivePermissionFocusView: View {
    
    let authManager: AuthManager
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(named: "FocusThumbnail") ?? UIImage())
            Text("#FocusAccess")
                .multilineTextAlignment(.center)
            Button("#FocusGrant"){
                impactFeedback.impactOccurred()
                authManager.requestAccessFocus()
            }
            .buttonStyle(.bordered)
        }
    }
}



