//
//  ContactsView.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 31.12.2023.
//

import Foundation
import SwiftUI

struct ContactsView: View {
    
    
    @StateObject var contactManager:ContactManager
    @StateObject var focusManager:FocusManager
    @State private var tableSortOrder = [KeyPathComparator(\ContactInfo.fullName)]
    var body: some View {
        NavigationStack{
            VStack {
                HStack{
                    ContactImage(contact: contactManager.thisDeviceContact, width: nil, height: nil)
                    VStack{
                        Text(contactManager.thisDeviceContact.fullName)
                        if focusManager.currentDeviceFocused {
                            HStack{
                                Image(systemName: "powersleep")
                                    .font(.caption)
                                    .foregroundStyle(.purple)
                                Text("#YouSilenced")
                                    .font(.caption)
                                    .foregroundStyle(.purple)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                Picker("#SortBy", selection: $tableSortOrder) {
                    Text("#NameAZ").tag([KeyPathComparator(\ContactInfo.fullName)])
                    Text("#NameZA").tag([KeyPathComparator(\ContactInfo.fullName, order: .reverse)])
                    Text("#FocusTop").tag([KeyPathComparator(\ContactInfo.isFocus.comparable)])
                    Text("#FocusBottom").tag([KeyPathComparator(\ContactInfo.isFocus.comparable, order: .reverse)])
                }.pickerStyle(SegmentedPickerStyle())
                //.frame(maxWidth: .infinity, alignment: .leading)
                
                var datasource = UserDefaults.standard.bool(forKey: UserDefaults.Keys.showOnlyFocused.rawValue) == true ? contactManager.contactData.filter{ $0.isFocus == true } : contactManager.contactData
                
                Table(datasource, sortOrder: $tableSortOrder){
                    TableColumn("#MyContacts"){ contact in
                        HStack{
                            NavigationLink(destination: ContactCardView(contact: contact)) {
                                ContactImage(contact: contact, width: nil, height: nil)
                                .foregroundColor(.white)
                                VStack{
                                    Text(contact.fullName)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .foregroundColor(.white)
                                    if contact.isFocus {
                                        HStack{
                                            Image(systemName: "powersleep")
                                                .font(.caption)
                                                .foregroundStyle(.purple)
                                            Text("#ContactSilenced")
                                                .font(.caption)
                                                .foregroundStyle(.purple)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }

                        }
                    }
                    
                }.onChange(of: tableSortOrder){ _ , newOrder in
                    contactManager.contactData.sort(using: newOrder)
                }
            }.refreshable {
                impactFeedback.impactOccurred()
                contactManager.fetchContacts()
            }
        }
        .navigationTitle("#Contacts")
    }
}
