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
            Text("#ContactsFocusDenied")
                .multilineTextAlignment(.center)
            Text("#ContactsFocusDeniedComment")
                .multilineTextAlignment(.center)
            Button("#GotoSettings"){
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
