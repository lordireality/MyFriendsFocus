//
//  DebugView.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 01.01.2024.
//

import Foundation
import SwiftUI

struct DebugView: View {
    
    var body : some View {

            Image(systemName: "person.crop.circle")
                .resizable()
               .scaledToFill()
               .frame(width: 50, height: 50)
               .cornerRadius(15)
       
    }
}
#Preview {
    DebugView()
}
