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
    
    
    @State private var testValue = false
    var body: some View {
        VStack {
            Text(testValue.description)
            Button {
                testValue.toggle()
            } label: {
                Text("Change Value, Right now its \(testValue.description)")
            }
            // Сделали подписку на этот массив, теперь всегда при изменении этого параметра, Table будет перерисовываться
            Table(viewModel.contactData){
                TableColumn("My Contacts"){ contact in
                    HStack{
                        ContactImage(contact: contact)
                        Text(contact.fullName)
                    }
                }
                
            }
        }
    }
    

}

#Preview {
    ContentView()
}
