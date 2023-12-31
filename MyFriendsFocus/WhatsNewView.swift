//
//  WhatsNewView.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 31.12.2023.
//

import Foundation
import SwiftUI

struct WhatsNewView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("чета новое").multilineTextAlignment(.center)
            Button("Начать") {
                dismiss()
            }
            .buttonStyle(.bordered)
        }
    }
    
    

}
#Preview(){
    WhatsNewView()
}
