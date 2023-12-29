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
                    // Здесь мы делаем цепочку развертываний, сначала проверяем есть ли дата, потом проверяем получилось ли создать картинку
                    // UIImage - структура, которую можно с кайфом передавать, она хранит в себе данные о картинке и можно ее изменять кучей методов
                    // Image - это чисто ui отображение картинки, не надо ее хранить нигде, лучше хранить UIImaage, Data, или ссылку на картинку
                    if let data = contact.profilePicData,
                    let image = UIImage(data: data){
                        // модификаторы к View элементам принято с новой строки писать, это сильно читабельнее и пизды могут дать если в строку будешь ебашить
                        Image(uiImage: image)
                            .frame(width: 50, height: 50)
                            .cornerRadius(15)
                    }
//                    contact.prof.resizable()
                    Text(contact.fullName)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
