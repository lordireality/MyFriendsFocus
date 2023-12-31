//
//  ContactManager.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 28.12.2023.
//

import Foundation
import Contacts

///Contact manager (ну а what ты хотел)
class ContactManager: ObservableObject{
    ///Is fetching contacts was succesfull
    var resp = false
    ///if exception on init was thrown, text will be placed here
    var ex:String? = nil
    
    // Published это враппер переменной, который отошлет всем ее подписчикам новое значение, это то же самое как враппер "@State", но только внутри классов
    ///array of fetched contacts
    @Published var contactData:[ContactInfo] = []
    
    init() {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactMiddleNameKey, CNContactThumbnailImageDataKey]
                    let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                    do {
                        try store.enumerateContacts(with: request) { contact, stop in
                            
                            self.contactData.append(ContactInfo(fullName: "\(contact.familyName) \(contact.givenName) \(contact.middleName)", profilePicData:  contact.thumbnailImageData))
                            
                            self.resp = true
                        }
                    } catch {
                        self.resp = false
                        self.ex = "Произошла ошибка при получении контактов: \n \(error)"
                        
                    }
                }
            } else {
                self.resp = false
                self.ex = "Ну и нах ты отклонил разрешение? Теперь топай в настройки включай и перезагружай аппу"
            }
        }
    }
}
