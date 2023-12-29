//
//  ContentView.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 28.12.2023.
//

import SwiftUI
import Foundation
import Contacts

struct ContentView: View {
    var body: some View {
        var contactData = ContactManager.init()
        if contactData.resp {
            Table(contactData.contactData){
                TableColumn("My Contacts"){ contact in
                    HStack{
                        contact.profilePicImg.resizable().frame(width: 50, height: 50).cornerRadius(15)
                        Text(contact.fullName)
                    }
                }
            }
        } else {
            Text(contactData.ex ?? "no exception but failed")
        }
    }
}

#Preview {
    ContentView()
}
