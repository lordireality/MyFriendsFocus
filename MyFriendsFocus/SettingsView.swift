//
//  SettingsView.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 01.01.2024.
//

import Foundation
import SwiftUI
import ContactsUI

struct SettingsView: View {
    @State private var selectedContact: CNContact?
    
    @Binding var isPresented: Bool
    
    var body : some View {
        
        VStack{
            //TODO: Addloader and handler
            Button("#ClearUD", action: UserDefaults.standard.reset)
                .buttonStyle(.bordered)
            Button("#SelectMyCard"){
            }
            .buttonStyle(.bordered)
            


        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }

}


