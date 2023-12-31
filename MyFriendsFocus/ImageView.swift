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
    var body : some View {
        if let data = contact.profilePicData,
           let image = UIImage(data: data){
           beatifulImg(uiImg: image)
       } else if let image = UIImage(named: "ContactThumbnail"){
           beatifulImg(uiImg: image)
       }
    }
    private func beatifulImg(uiImg: UIImage) -> some View{
        Group{
            Image(uiImage: uiImg)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .cornerRadius(15)
        }
    }
    
}


