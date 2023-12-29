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
    // StateObject нужен для хранения классов, за которыми View будет наблюдать и автоматически перерисовывать ui если наблюдаемые параметры изменились
    @StateObject private var viewModel = ContactManager()
    var body: some View {
        // Сделали подписку на этот массив, теперь всегда при изменении этого параметра, Table будет перерисовываться
        Table(viewModel.contactData){
            TableColumn("My Contacts"){ contact in
                HStack{
                    contact.profilePicImg.resizable().frame(width: 50, height: 50).cornerRadius(15)
                    Text(contact.fullName)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
