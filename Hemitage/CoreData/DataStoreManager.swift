//
//  DataStoreManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 19.05.2021.
//

import Foundation
import CoreData



class DataStoreManager {
    
    private var dataManager: FireStoreDataManagerProtocol = FireStoreDataManager()
    
    // MARK: - Core Data stack
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Hemitage")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    private lazy var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    
    // MARK: - CRUD
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func getDataFromDB() {
        dataManager.callBack = { [weak self] result in
            
            switch result.collection {
            
            case .blog:
                guard let data = result.data as? BlogModel, let self = self else { return }
                
                switch result.typeOfChange {
                case .added, .modified:
                    let item = Article(context: self.viewContext)
                    
                    item.id               = data.id
                    item.title            = data.title
                    item.subtitle         = data.subtitle
                    item.date             = data.date
                    item.previewImageName = data.previewImageName
                    
                    self.saveContext()
                    
                case .removed:
                    if let item: Article = self.buildRequest(id: data.id, object: Article.self)?[0] {
                        self.viewContext.delete(item)
                        self.saveContext()
                    }
                }
                
                
            default: break
            }
        }
        dataManager.fetchData(from: .blog)
    }
    
    
    private func buildRequest<T: NSManagedObject>(id: String, object: T.Type) -> [T]? {
        let predicate = NSPredicate(format: "id == %@", id)
        
        let request: NSFetchRequest<T>? = T.fetchRequest() as? NSFetchRequest<T>
        request?.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate])
        
        guard let safeRequest = request else { return nil }
        
        do {
            let items = try viewContext.fetch(safeRequest)
            return items
        }
        catch {
            print ("Error fetching items from context: \(error.localizedDescription)")
        }
        
        return nil
    }
}

