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
    @State var showingSelContactSelect:Bool = false
    @State var showingUDAlert:Bool = false
    @State private var showOnlyFocused = UserDefaults.standard.bool(forKey: UserDefaults.Keys.showOnlyFocused.rawValue)
    @State private var showSelectedContacts = UserDefaults.standard.bool(forKey: UserDefaults.Keys.showSelected.rawValue)
    @State private var selectedContacts:[DBSelectedContacts] = []
    @State private var lastSelContact: CNContact?
    private var dbm = DBManager.shared

    var body : some View {
        
        VStack{
            //TODO: Addloader and handler
            Button("#ClearUD"){
                impactFeedback.impactOccurred()
                UserDefaults.standard.reset()
                showingUDAlert = true
            }
            .buttonStyle(.bordered)
            .alert("#UDCleared", isPresented: $showingUDAlert) {
                Button("#OK", role: .cancel) { }
            }
            Divider()
            HStack{
                Button("#SelectMyCard"){
                    showingContactSelect = true
                }
                .buttonStyle(.bordered)
                .sheet(isPresented: $showingContactSelect, onDismiss: setMyCard) {
                    ContactPickerView(selectedContact: $lastSelContact)
                            
                }
                
                //TODO: Add remove my card
            }
            Divider()
            Toggle("#ShowFocusedOnly", isOn: $showOnlyFocused)
            .onChange(of: showOnlyFocused){
                impactFeedback.impactOccurred()
                UserDefaults.standard.set(showOnlyFocused, forKey: UserDefaults.Keys.showOnlyFocused.rawValue)
            }
            Divider()
            VStack{
                Toggle("#ShowSelectedContacts", isOn: $showSelectedContacts)
                .onChange(of: showSelectedContacts){
                    impactFeedback.impactOccurred()
                    UserDefaults.standard.set(showSelectedContacts, forKey: UserDefaults.Keys.showSelected.rawValue)
                }
                if showSelectedContacts == true {
                    NavigationStack {
                        List {
                            ForEach(selectedContacts) { selectedContacts in
                                Text(selectedContacts.contactIndentifier!)
                            }
                            .onDelete{ index in
                                Task {
                                    await deleteRelated(at: index)
                                }
                            }
                        }.refreshable {
                            task {
                                var res = await DBManager.shared.getRelations()
                                if !res.isEmpty{
                                    selectedContacts.removeAll()
                                    selectedContacts += res
                                }
                            }
                        }
                        
                    }
                    Button("#AddContactToSelected"){
                        impactFeedback.impactOccurred()
                        showingSelContactSelect = true
                    }
                    .buttonStyle(.bordered)
                    .sheet(isPresented: $showingSelContactSelect, onDismiss: addToList) {
                        ContactPickerView(selectedContact: $lastSelContact)
                    }
                }
                
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    func deleteRelated(at offsets: IndexSet) async {
        for index in offsets {
            let relContact = selectedContacts[index]
            var res = await dbm.removeContactRelation(contactRelation: relContact)
            selectedContacts.remove(at: index)
        }
    }
    func setMyCard(){
        if let lastSelContact{
            UserDefaults.standard.set(lastSelContact.identifier, forKey: UserDefaults.Keys.thisDeviceContactIdentifier.rawValue)
            
        }
        lastSelContact = nil
    }
    func addToList(){
        if let lastSelContact{
            Task {
                var res = await dbm.createContactRelation(contactIdentifier: lastSelContact.identifier)
            }
                
        }
        lastSelContact = nil
    }
}


//честно спиздил и переписал
struct ContactPickerView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedContact: CNContact?

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
            parent.selectedContact = contact

            parent.presentationMode.wrappedValue.dismiss()

        }
        func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            parent.selectedContact = nil
        }
    }
}



