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
            HStack{
                ContactImage(contact: contactManager.thisDeviceContact)
                VStack{
                    Text(contactManager.thisDeviceContact.fullName)
                    if focusManager.currentDeviceFocused {
                        HStack{
                            Image(systemName: "powersleep")
                                .font(.caption)
                                .foregroundStyle(.purple)
                            Text("Вы сейчас заглушаете свои уведомления")
                                .font(.caption)
                                .foregroundStyle(.purple)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            
            Table(contactManager.contactData){
                TableColumn("My Contacts"){ contact in
                    HStack{
                        ContactImage(contact: contact)
                        VStack{
                            Text(contact.fullName)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            if contact.isFocus {
                                HStack{
                                    Image(systemName: "powersleep")
                                        .font(.caption)
                                        .foregroundStyle(.purple)
                                    Text("Заглушает свои уведомления")
                                        .font(.caption)
                                        .foregroundStyle(.purple)
                                }.frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }.frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
            }.refreshable {
                contactManager.fetchContacts()
            }
        }
    }
    

}
