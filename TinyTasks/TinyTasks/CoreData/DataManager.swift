//
//  DataManager.swift
//  TinyTasks
//
//  Created by Victor Mihaita on 16.05.2023.
//

import CoreData

class DataManager {
    static let shared = DataManager()
        let container: NSPersistentContainer

        var viewContext: NSManagedObjectContext {
            return container.viewContext
        }

        init(inMemory: Bool = false) {
            container = NSPersistentContainer(name: "TinyTasks1")
            if inMemory {
                container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
            }
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            container.viewContext.automaticallyMergesChangesFromParent = true
        }
}
