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
            ScrollView(.vertical){
                ForEach(contactData.contactData) { contact in
                    HStack{
                        //here swift is showing issue, that downcasting is unnecessary, BUT! SWIFT JIVOTNAE if we use nil'able var we will get exception, because data for UIImage cannot be nil. KOHTOPA nUDOPACOB
                        if let imageData = contact.profilePicData as? Data {
                            Image(uiImage: UIImage(data: imageData) ?? UIImage()).resizable().frame(width: 50, height: 50).cornerRadius(15)
                        }
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
