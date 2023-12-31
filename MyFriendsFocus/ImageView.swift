//
//  ImageView.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 31.12.2023.
//

import Foundation
import SwiftUI

struct ContactImage: View {
    let contact: ContactInfo
    let width: CGFloat?
    let height: CGFloat?
    var body : some View {
        if let data = contact.profilePicData,
           let image = UIImage(data: data){
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: width ?? 50, height: height ?? 50)
                .cornerRadius(15)
        } else {
            Image(systemName: "person.crop.circle")
                .resizable()
               .scaledToFill()
               .frame(width: width ?? 50, height: height ?? 50)
               .cornerRadius(15)
       }
    }
}

