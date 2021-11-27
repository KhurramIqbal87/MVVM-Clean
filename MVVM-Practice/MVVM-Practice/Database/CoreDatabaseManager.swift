//
//  CoreDatabaseManager.swift
//  MVVM-Practice
//
//  Created by Khurram Iqbal on 21/11/2021.
//

import Foundation
import CoreData

final class CoreDatabaseManager{
    
    private var moc: NSManagedObjectContext{
        return self.persistentContainer.viewContext
    }

    // MARK: - Core Data stack
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataStorage")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                // TODO: - Log to Crashlytics
                assertionFailure("CoreDataStorage Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // TODO: - Log to Crashlytics
                assertionFailure("CoreDataStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }

    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }
    
}

extension CoreDatabaseManager{
    func save( obj: Any) throws {
        
    }
    
    func fetch<T: NSManagedObject>( query: String?,completion: @escaping((_ results: [T]?) ->Void))throws {

        let fetchRequest:NSFetchRequest<T> = self.getFetchRequest()
        
        let predicate = NSPredicate.init(format: query ?? "")
        
        fetchRequest.predicate = predicate
        
        self.performBackgroundTask { context in
//                try? completion(try? context.fetch(fetchRequest))
            let results = try? context.fetch(fetchRequest)
            try? completion(results)
            
        }
    }
    
    private func getFetchRequest<T: NSManagedObject>()->NSFetchRequest<T>{

        return NSFetchRequest<T>(entityName: "\(T.self)")
        
    }
    
    
    func update<T:NSManagedObject>( query: String, completion: @escaping(( _ managedObject: T?)->Void))throws  {
        
        let fetchRequest: NSFetchRequest<T> = self.getFetchRequest()
        
        let predicate = NSPredicate.init(format: query )
        
        fetchRequest.predicate = predicate
        
        self.performBackgroundTask { context in

            let results = try? context.fetch(fetchRequest)
            completion(results?.first)
            
        }
    }
    
    func delete(entities : [NSManagedObject])  {
        
        for entity in entities{
            self.persistentContainer.viewContext.delete(entity)
        }
    }
}

