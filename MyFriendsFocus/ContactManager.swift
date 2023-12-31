//
//  ContactManager.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 28.12.2023.
//

import Foundation
import Contacts
class ContactManager: ObservableObject{
    ///array of fetched contacts
    @Published var contactData:[ContactInfo] = []
    ///Is fetching contacts was succesfull
    var resp = false
    ///if exception on fectch contacts was thrown, text will be placed here
    var ex:String? = nil
    //Store
    var store: CNContactStore = CNContactStore()
    ///Fetches contacts from devies.
    func fetchContacts(){
        DispatchQueue.main.async {
            self.contactData.removeAll()
            let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactMiddleNameKey, CNContactThumbnailImageDataKey]
            let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
            do {
                //TODO:
                //This method should not be called on the main thread as it may lead to UI unresponsiveness.
                //WTF???
                try self.store.enumerateContacts(with: request) { contact, stop in
                    self.contactData.append(ContactInfo(fullName: "\(contact.familyName) \(contact.givenName) \(contact.middleName)", profilePicData:  contact.thumbnailImageData))
                    self.resp = true
                }
            } catch {
                self.resp = false
                self.ex = "\(error)"
                
            }
        }
    }
    init(store: CNContactStore){
        self.store = store
        fetchContacts()
    }
}
///AuthManager
class AuthManager: ObservableObject{
    ///Contact store
    var store: CNContactStore = CNContactStore()
    ///Is access to contacts granted
    @Published var accessGranted:CNAuthorizationStatus = .notDetermined
    
    func checkAcess(){
        accessGranted = CNContactStore.authorizationStatus(for: .contacts)
    }
    
    ///Requests access to CNContactStore
    func requestAccess(){
        DispatchQueue.main.async {
            self.store.requestAccess(for: .contacts) { granted, error in
                //проверка что гой не на наебал на акцес
                self.checkAcess()
            }
        }
        
    }
    
    init() {
        checkAcess();
    }
}
