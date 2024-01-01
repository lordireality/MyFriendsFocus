//
//  AccessDeniedView.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 31.12.2023.
//

import Foundation
import SwiftUI
import CoreHaptics

struct AccessDeniedView: View {

    var body: some View {
        VStack {
            Image(uiImage: UIImage(named: "SettingsThumbnail") ?? UIImage())
            Text("Доступ к контактам или фокусировке запрещен.")
                .multilineTextAlignment(.center)
            Text("Для работы приложения, необходимо предоставить доступ к контактам и состоянию фокусировки устройства")
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
