//
//  DBManager.swift
//  MyFriendsFocus
//
//  Created by Герман Зыкин on 07.01.2024.
//

import Foundation
import CoreData
import os


class DBManager: ObservableObject{
    public var container: NSPersistentContainer
    
    lazy var backgroundContext: NSManagedObjectContext = {
        let newbackgroundContext = container.newBackgroundContext()
        newbackgroundContext.automaticallyMergesChangesFromParent = true
        return newbackgroundContext
    }()
    
    private init(){
        let container = NSPersistentContainer(name: "MyFriendsFocusDataModel")
        container.loadPersistentStores { storeDescription, error in
            if let error {
                fatalError("Error while initialising Cotainer \(error.localizedDescription)")
            }
        }
        self.container = container
    }
    
    public static let shared = DBManager.init()
    
    private func saveContext(){
        let context = self.backgroundContext
        if context.hasChanges{
            do{
                try context.save()
            }catch{
                print("Save error \(error.localizedDescription)")
            }
        }
    }
    
    func createContactRelation(contactIdentifier: String) async -> DBSelectedContacts?{
        await withCheckedContinuation({ continuation in
            self.backgroundContext.performAndWait{
                let req = DBSelectedContacts.fetchRequest()
                let predicate = NSPredicate(format: "contactIndentifier == %@", contactIdentifier)
                req.predicate = predicate
                req.fetchLimit = 1
                let res = (try? self.backgroundContext.fetch(req)) ?? []
                if !res.isEmpty{
                    continuation.resume(returning: nil)
                } else {
                    let contactRelation = DBSelectedContacts(context: self.backgroundContext)
                    contactRelation.id = .init()
                    contactRelation.contactIndentifier = contactIdentifier
                    self.saveContext()
                    continuation.resume(returning: contactRelation)
                }
                
            }
        })
    }
    func removeContactRelation (contactRelation: DBSelectedContacts) async -> Bool?{
        await withCheckedContinuation({ continuation in
            self.backgroundContext.performAndWait{
                self.backgroundContext.delete(contactRelation)
                self.saveContext()
                continuation.resume(returning: true)
            }
        })
        
    }
    func getRelations() async -> [DBSelectedContacts]{
        await withCheckedContinuation({ continuation in
            self.backgroundContext.performAndWait{
                let request = DBSelectedContacts.fetchRequest()
                do{
                    let items = try self.backgroundContext.fetch(request)
                    continuation.resume(returning: items)
                }catch{
                    
                    continuation.resume(returning: [])
                }
            }
        })
    }
}
    
    

    
