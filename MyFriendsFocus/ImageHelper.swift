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
    // Даункастить не надо, у тебя Data является опциональным параметром, это enum у которого два значения, наличие значения или его отсутствие
    // процесс обработки опционалов называется развертывание, optional unwrapping, почитай
    // в данном случае if в переменной data есть значение, а не нил, то создаем новоую переменную с этой хуйней imageData
    if let imageData = data {
        return Image(uiImage: UIImage(data: imageData) ?? UIImage())
    } else {
        return Image(uiImage: UIImage(named: defaultNamed) ?? UIImage())
    }
}

