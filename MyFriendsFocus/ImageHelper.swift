//
//  ImageHelper.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 29.12.2023.
//

import Foundation
import SwiftUI

func getImageFromData(data:Data?, defaultNamed:String)->Image{
    //here swift is showing issue, that downcasting is unnecessary, BUT! SWIFT JIVOTNAE if we use nil'able var we will get exception, because data for UIImage cannot be nil. KOHTOPA nUDOPACOB
    if let imageData = data as? Data {
        return Image(uiImage: UIImage(data: imageData) ?? UIImage())
    } else {
        return Image(uiImage: UIImage(named: defaultNamed) ?? UIImage())
    }
}

