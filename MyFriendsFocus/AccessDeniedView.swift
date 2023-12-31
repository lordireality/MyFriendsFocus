//
//  AccessDeniedView.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 31.12.2023.
//

import Foundation
import SwiftUI

struct AccessDeniedView: View {
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(named: "SettingsThumbnail") ?? UIImage())
            Text("Доступ к контактам запрещен.")
                .multilineTextAlignment(.center)
            Text("Для работы приложения, необходимо предоставить доступ к контактам")
                .multilineTextAlignment(.center)
            Button("Перейти в настройки"){
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            .buttonStyle(.bordered)
        }
    }
    
  

}
#Preview(){
    AccessDeniedView()
}
