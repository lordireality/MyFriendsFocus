//
//  SettingsView.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 01.01.2024.
//

import Foundation
import SwiftUI
import ContactsUI

struct SettingsView: View {
    
    @State var showingContactSelect:Bool = false
    var hapticManager = HapticManager()
    var body : some View {
        
        VStack{
            //TODO: Addloader and handler
            Button("#ClearUD", action: UserDefaults.standard.reset)
                .buttonStyle(.bordered)
            Button("#SelectMyCard"){
                showingContactSelect = true
            }
            .buttonStyle(.bordered)
            .sheet(isPresented: $showingContactSelect) {
                ContactPickerView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }

}


//честно спиздил и переписал
struct ContactPickerView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let picker = CNContactPickerViewController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: Context) {
        // Ничего не нужно обновлять
    }

    class Coordinator: NSObject, CNContactPickerDelegate {
        var parent: ContactPickerView

        init(_ parent: ContactPickerView) {
            self.parent = parent
        }

        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            UserDefaults.standard.set(contact.identifier, forKey: UserDefaults.Keys.thisDeviceContactIdentifier.rawValue)
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}



