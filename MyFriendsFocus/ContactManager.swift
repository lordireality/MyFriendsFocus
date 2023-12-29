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
    ///array of fetched contacts
    var contactData:[ContactInfo] = []
    
    init() {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { granted, error in
            if granted {
                //sheeesh, CN naming and this stuff, actually looks like Microsoft ActiveDirectory....... and working almost same...
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactMiddleNameKey, CNContactThumbnailImageDataKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    //TODO: fix this (it dont impress me, oh no)
                    //This method should not be called on the main thread as it may lead to UI unresponsiveness.
                    //мне похуй, на 13 мини не лагает юай. а те у кого телефон ниже советую уволится из макдака либо вообще найти работу бтв там деньги платят
                    /*
                     upd. spasibo Vlad, i dont know how to use this...
                     DispatchQueue.global().async {
                     DolongNotUiThing()
                     }
                     */
                    try store.enumerateContacts(with: request) { contact, stop in
                        
                        //TODO: Add from siri-kit recieve contact focus
                        //idk how it supposed to work
                        self.contactData.append(ContactInfo(fullName: "\(contact.familyName) \(contact.givenName) \(contact.middleName)", profilePicData:  contact.thumbnailImageData, profilePicImg: getImageFromData(data: contact.thumbnailImageData, defaultNamed: "ContactThumbnail")))
                        self.resp = true
                    }
                } catch {
                    self.resp = false
                    self.ex = "Произошла ошибка при получении контактов: \n \(error)"
                    
                }
            } else {
                self.resp = false
                self.ex = "Ну и нах ты отклонил разрешение? Теперь топай в настройки включай и перезагружай аппу"
            }
        }
    }
}
