//
//  ContactInfoViewModel.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 29.12.2023.
//

import Foundation

/// Model for passing data to content view from Manager
struct ContactInfo : Identifiable {
    ///
    let id = UUID()
    ///FullName of a contact to be displayed
    var fullName:String = "";
    ///Is specified contact have applied focus
    var isFocus:Bool = false;
    ///Contact photo. If no photo set - nil
    var profilePicData:Data? = nil
}

