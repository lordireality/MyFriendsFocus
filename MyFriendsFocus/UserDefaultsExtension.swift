//
//  UserDefaultsExtension.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 01.01.2024.
//

import Foundation

extension UserDefaults {

    enum Keys: String, CaseIterable {
        case FirstAppLaunch
        case thisDeviceContactIdentifier
        case showOnlyFocused
        case showSelected
    }
    func reset() {
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }

}
