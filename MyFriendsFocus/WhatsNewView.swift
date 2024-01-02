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
    let impactFeedback: UIImpactFeedbackGenerator

    var body: some View {
        VStack {
            HStack{
                Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                    .resizable()
                    .frame(width: 100.0, height: 100.0)
                Text("#WhatsNew")
                    .font(.largeTitle)
            }
            Divider()
            Text("1. Пока ничего, но мы стараемся")
            .multilineTextAlignment(.center)
            VStack{
                Divider()
                if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                    Text("#Ver\(version)")
               }
                Divider()
                Button("#Start") {
                    impactFeedback.impactOccurred()
                    dismiss()
                }.font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .cornerRadius(15)
                .buttonStyle(.bordered)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    

}
