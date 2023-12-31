//
//  ContactsView.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 31.12.2023.
//

import Foundation
import SwiftUI

struct ContactsView: View {
    
    
    @StateObject var contactManager:ContactManager
    @StateObject var focusManager:FocusManager
    
    var body: some View {
        VStack {
            Table(contactManager.contactData){
                TableColumn("My Contacts"){ contact in
                    HStack{
                        ContactImage(contact: contact)
                        Text(contact.fullName)
                    }
                }
                
            }.refreshable {
                contactManager.fetchContacts()
            }
        }
    }
    

}
