//
//  ContactManager.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 28.12.2023.
//

import Foundation
import Contacts
import Intents

class FocusManager: ObservableObject{
    var statusCentre:INFocusStatusCenter = INFocusStatusCenter.default
    @Published var currentDeviceFocused = false
    
    func updateFocusState(){
        //получаем состояние фокусировки. Если инф-ция не получена, считаем что устройство не в фокусе
        self.currentDeviceFocused = self.statusCentre.focusStatus.isFocused ?? false
    }
    
    init(statusCentre: INFocusStatusCenter){
        self.statusCentre = statusCentre
        updateFocusState()
    }
}


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
    var statusCentre:INFocusStatusCenter = INFocusStatusCenter.default
    @Published var accessGrantedContacts:CNAuthorizationStatus = .notDetermined
    @Published var accessGrantedFocus:INFocusStatusAuthorizationStatus = .notDetermined
    
    func checkAccessContacts(){
        self.accessGrantedContacts = CNContactStore.authorizationStatus(for: .contacts)
    }
    
    func checkAccessFocus(){
        self.accessGrantedFocus = self.statusCentre.authorizationStatus
    }
    
    func requestAccessContacts(){
        DispatchQueue.main.async {
            self.store.requestAccess(for: .contacts) { granted, error in
               self.checkAccessContacts()
            }
        }
    }
    
    func requestAccessFocus(){
        DispatchQueue.main.async {
            self.statusCentre.requestAuthorization { status in
                self.checkAccessFocus()
            }
        }
    }
    
    
    
    
    ///Is access to contacts granted
    @available(*, deprecated)
    @Published var accessGranted:CNAuthorizationStatus = .notDetermined
    
    @available(*, deprecated)
    func checkAcess(){
        accessGranted = CNContactStore.authorizationStatus(for: .contacts)
    }
    
    ///Requests access to CNContactStore
    @available(*, deprecated)
    func requestAccess(){
        DispatchQueue.main.async {
            self.store.requestAccess(for: .contacts) { granted, error in
                //проверка что гой не на наебал на акцес
                self.checkAcess()
            }
        }
        
    }
    
    init() {
        checkAccessContacts()
        checkAccessFocus()
    }
}
