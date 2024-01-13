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
        DispatchQueue.main.async {
            //получаем состояние фокусировки. Если инф-ция не получена, считаем что устройство не в фокусе
            //p.s. Очень жидкий надрист вышел. Нужен Communication Notifications Capability для работы
            self.currentDeviceFocused = self.statusCentre.focusStatus.isFocused ?? false
        }
    }
    
    init(statusCentre: INFocusStatusCenter){
        self.statusCentre = statusCentre
        updateFocusState()
    }
}


class ContactManager: ObservableObject{
    ///array of fetched contacts
    @Published var contactData:[ContactInfo] = []
    ///this device contact
    @Published var thisDeviceContact:ContactInfo = ContactInfo(fullName: "Вы", isFocus: false, profilePicData: nil)
    ///Is fetching contacts was succesfull
    var resp = false
    ///if exception on fectch contacts was thrown, text will be placed here
    var ex:String? = nil
    //Store
    var store: CNContactStore = CNContactStore()
    
    func compareContacts(identifier: String) -> ContactInfo?{
        if thisDeviceContact.identifier == identifier{
            return thisDeviceContact
        }
        return contactData.filter{ $0.identifier == identifier }.first
    }
    
    
    ///Fetches contacts from devies.
    func fetchContacts(){
        DispatchQueue.main.async {
            self.contactData.removeAll()
            self.thisDeviceContact = ContactInfo(fullName: "Вы", isFocus: false, profilePicData: nil);
        }
        Task{
            let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactMiddleNameKey, CNContactThumbnailImageDataKey, CNContactIdentifierKey]
            let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
            //request.predicate = CNContact.predicateForContacts(withIdentifiers: ["8A05765-1BF2-4063-A428-07D4543F8261"])
            if UserDefaults.standard.bool(forKey: UserDefaults.Keys.showSelected.rawValue) == true{
                    var relations = await DBManager.shared.getRelations()
                    var identifiers = relations.map{ ($0.contactIndentifier ?? "")}
                    if let thisdevice =  UserDefaults.standard.string(forKey: UserDefaults.Keys.thisDeviceContactIdentifier.rawValue){
                        identifiers.append(thisdevice)
                    }
                    request.predicate = CNContact.predicateForContacts(withIdentifiers: identifiers)
                
            }
            DispatchQueue.global().async {
                do {
                    try self.store.enumerateContacts(with: request) { contact, stop in
                        DispatchQueue.main.async {
                            if(contact.identifier != UserDefaults.standard.string(forKey: UserDefaults.Keys.thisDeviceContactIdentifier.rawValue)){
                                self.contactData.append(ContactInfo(identifier: contact.identifier, fullName: "\(contact.familyName) \(contact.givenName) \(contact.middleName)", profilePicData:  contact.thumbnailImageData))
                            } else {
                                self.thisDeviceContact = ContactInfo(identifier: contact.identifier, fullName: "\(contact.familyName) \(contact.givenName) \(contact.middleName)", profilePicData:  contact.thumbnailImageData)
                            }
                        }
                        
                        
                        self.resp = true
                    }
                } catch {
                    self.resp = false
                    self.ex = "\(error)"
                    
                }
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
    
    init() {
        checkAccessContacts()
        checkAccessFocus()
    }
}
