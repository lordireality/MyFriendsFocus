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
            HStack{
                Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                    .resizable()
                    .frame(width: 100.0, height: 100.0)
                Text("Что нового в MyFriendsFocus")
                    .font(.largeTitle)
            }
            Divider()
            Text("1. Пока ничего, но мы стараемся")
            .multilineTextAlignment(.center)
            VStack{
                Divider()
                if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                    Text("Версия: \(version)")
               }
                Divider()
                Button("Начать") {
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
