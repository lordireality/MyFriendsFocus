//
//  SettingsView.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 01.01.2024.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    
    var body : some View {
        VStack{
            //TODO: Addloader and handler
            Button("Очистить UserDefaults", action: UserDefaults.standard.reset)
                .buttonStyle(.bordered)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }

}
