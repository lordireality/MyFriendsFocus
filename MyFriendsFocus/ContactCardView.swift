//
//  ContactCardView.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 03.01.2024.
//

import Foundation
import SwiftUI
//import UIKit


struct ContactCardView: View {
    let contact:ContactInfo
    //@State private var orientation = UIDeviceOrientation.unknown

    
    var body : some View {
        ScrollView{
            VStack{
                /*if !orientation.isLandscape || !orientation.isPortrait{
                    HStack{
                        ContactImage(contact: contact, width: 100, height: 100)
                        Divider()
                        VStack{
                            Text(contact.fullName)
                                .font(.title)
                            if contact.isFocus {
                                HStack{
                                    Image(systemName: "powersleep")
                                        .font(.caption)
                                        .foregroundStyle(.purple)
                                    Text("#ContactSilenced")
                                        .font(.caption)
                                        .foregroundStyle(.purple)
                                }
                            }
                        }
                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                } else {*/
                    VStack{
                        ContactImage(contact: contact, width: 200, height: 200)
                        Divider()
                        Text(contact.fullName)
                            .font(.title)
                        if contact.isFocus {
                            HStack{
                                Image(systemName: "powersleep")
                                    .font(.caption)
                                    .foregroundStyle(.purple)
                                Text("#ContactSilenced")
                                    .font(.caption)
                                    .foregroundStyle(.purple)
                            }
                        }
                    //}
                }
                Divider()

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }/*.onRotate { newOrientation in
            orientation = newOrientation
        }*/
    }
}
#Preview {
    ContactCardView(contact: ContactInfo(fullName: "Вы", isFocus: false, profilePicData: nil))
}
