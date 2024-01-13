//
//  ContactInfoViewModel.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 29.12.2023.
//

import Foundation
import Contacts

/// Model for passing data to content view from Manager
struct ContactInfo : Identifiable {
    ///local id
    let id = UUID()
    ///identifier from CNContactStore
    var identifier: String = "";
    ///FullName of a contact to be displayed
    var fullName:String = "";
    ///Is specified contact have applied focus
    var isFocus:Bool = false;
    ///Contact photo data. If no photo set - nil
    var profilePicData:Data? = nil    
}

