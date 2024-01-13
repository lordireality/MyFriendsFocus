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
    //TODO: Refactor this
    var contactManager:ContactManager
    @State private var showingContactSelect:Bool = false
    @State private var showingSelContactSelect:Bool = false
    @State private var showingUDAlert:Bool = false
    @State private var showingRemoveMyCardAlert:Bool = false
    @State private var showOnlyFocused = UserDefaults.standard.bool(forKey: UserDefaults.Keys.showOnlyFocused.rawValue)
    @State private var showSelectedContacts = UserDefaults.standard.bool(forKey: UserDefaults.Keys.showSelected.rawValue)
    @State private var selectedContacts:[DBSelectedContacts] = []
    @State private var lastSelContact: CNContact?
    private let dbm = DBManager.shared
    public init(contactManager:ContactManager){
        self.contactManager = contactManager
    }
    var body : some View {
        VStack{
            Button("#ClearUD"){
                impactFeedback.impactOccurred()
                UserDefaults.standard.reset()
                contactManager.fetchContacts()
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
                Button("#RemoveMyCard"){
                    impactFeedback.impactOccurred()
                    UserDefaults.standard.removeObject(forKey: UserDefaults.Keys.thisDeviceContactIdentifier.rawValue)
                    contactManager.fetchContacts()
                    showingRemoveMyCardAlert = true
                }
                .buttonStyle(.bordered)
                .alert("#MyCardCleared", isPresented: $showingRemoveMyCardAlert) {
                    Button("#OK", role: .cancel) { }
                }
            }
            Divider()
            Toggle("#ShowFocusedOnly", isOn: $showOnlyFocused)
            .padding(.trailing, 5)
            .onChange(of: showOnlyFocused){
                impactFeedback.impactOccurred()
                UserDefaults.standard.set(showOnlyFocused, forKey: UserDefaults.Keys.showOnlyFocused.rawValue)
            }
            Divider()
            VStack{
                Toggle("#ShowSelectedContacts", isOn: $showSelectedContacts)
                    .padding(.trailing, 5)
                .onChange(of: showSelectedContacts){
                    impactFeedback.impactOccurred()
                    UserDefaults.standard.set(showSelectedContacts, forKey: UserDefaults.Keys.showSelected.rawValue)
                    contactManager.fetchContacts()
                }

                if showSelectedContacts == true {
                    
                    Button("#AddContactToSelected"){
                        impactFeedback.impactOccurred()
                        showingSelContactSelect = true
                    }
                    .buttonStyle(.bordered)
                    .sheet(isPresented: $showingSelContactSelect, onDismiss: addRelatedToList) {
                        ContactPickerView(selectedContact: $lastSelContact)
                    }
                    
                    List {
                        ForEach(selectedContacts) { selectedContacts in
                            if let identifier = selectedContacts.contactIndentifier {
                                let contactInfo = contactManager.compareContacts(identifier: identifier)
                                Text(contactInfo?.fullName ?? "#DeletedContact")
                            } else {
                                Text("#DeletedContact")
                            }
                        }
                        .onDelete{ index in
                            Task {
                                await deleteRelated(at: index)
                            }
                        }
                    }.refreshable {
                        getRelated()
                    }
                    .onAppear(){
                        getRelated()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    func deleteRelated(at offsets: IndexSet) async {
        for index in offsets {
            let relContact = selectedContacts[index]
            if await dbm.removeContactRelation(contactRelation: relContact) == true{
                contactManager.fetchContacts()
                getRelated()
            }
            
        }
    }
    func getRelated(){
        Task {
            let res = await DBManager.shared.getRelations()
            if !res.isEmpty{
                selectedContacts.removeAll()
                selectedContacts += res
            }
        }
    }
    func setMyCard(){
        if let lastSelContact{
            UserDefaults.standard.set(lastSelContact.identifier, forKey: UserDefaults.Keys.thisDeviceContactIdentifier.rawValue)
            
        }
        lastSelContact = nil
        contactManager.fetchContacts()
    }
    func addRelatedToList(){
        Task{
            if let lastSelContact{
                let res = await dbm.createContactRelation(contactIdentifier: lastSelContact.identifier)
                if let res {
                    contactManager.fetchContacts()
                    getRelated()
                }
            }
        lastSelContact = nil
        }
        
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



