//
//  DataStoreManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 19.05.2021.
//

import Foundation
import CoreData

protocol CoreDataManager {
    var viewContext: NSManagedObjectContext { get }
    
    func createRequest(from collection: FireStoreCollectionName, sortByField: String) -> NSFetchRequest<NSManagedObject>
    /**
     Method returns all elements from the given collection
     */
    func getAllItems(from collection: FireStoreCollectionName, completion: ([NSManagedObject]) -> ())
}

class DataStoreManager: CoreDataManager {
    private var dataManager: FireStoreDataManagerProtocol = FireStoreDataManager()
    
    // MARK: - Core Data stack
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Hemitage")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    lazy var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    
    func createRequest(from collection: FireStoreCollectionName, sortByField: String = "id") -> NSFetchRequest<NSManagedObject> {
        
        switch collection {
        case .blog:
            let articleRequest: NSFetchRequest<Article> = Article.fetchRequest()
            articleRequest.sortDescriptors = [NSSortDescriptor(key: sortByField, ascending: true)]
            guard let request = articleRequest as? NSFetchRequest<NSManagedObject> else {
                    fatalError("Can't create request")
            }
        
            return request
            
        default: break
        }
        
        fatalError("Can't create request")
    }
    
    // MARK: - CRUD
    private func saveContext() {
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
    
    
    func getAllItems(from collection: FireStoreCollectionName, completion: ([NSManagedObject]) -> ())  {
         
        let request = createRequest(from: collection)
        if let data = getItems(with: request) {
            completion(data)
        }
        
        getDataFromDB(from: collection)
    }
    
    
    private func getDataFromDB(from collection: FireStoreCollectionName) {
        dataManager.callBack = { [weak self] result in
            
            switch result.collection {
            case .blog:
                guard let data = result.data as? [BlogModel],
                      let self = self
                else { return }
                
                
                switch result.typeOfChange {
                case .added, .modified:
                    data.forEach { model  in
                        let items = self.buildRequest(id: model.id, object: Article.self)
                        
                        let itemToUpdate: Article = items?.count != 0
                            ? (items?[0] ?? Article(context: self.viewContext))
                            : Article(context: self.viewContext)
                        
                        itemToUpdate.id               = model.id
                        itemToUpdate.title            = model.title
                        itemToUpdate.subtitle         = model.subtitle
                        itemToUpdate.date             = model.date
                        itemToUpdate.previewImageName = model.previewImageName
                        
                        self.saveContext()
                    }
                
                case .removed:
                    data.forEach { model in
                        if let item = self.buildRequest(id: model.id, object: Article.self)?[0] {
                            self.viewContext.delete(item)
                            self.saveContext()
                        }
                    }
                }
                
            default: break
            }
        }
        
        dataManager.fetchData(from: collection)
    }
    
    
    private func buildRequest<T: NSManagedObject>(id: String, object: T.Type) -> [T]? {
        let predicate = NSPredicate(format: "id == %@", id)
        
        let request: NSFetchRequest<T>? = T.fetchRequest() as? NSFetchRequest<T>
        request?.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate])
        
        guard let safeRequest = request else { return nil }
        return getItems(with: safeRequest)
    }
    
    
    private func getItems<T: NSManagedObject> (with request: NSFetchRequest<T>) -> [T]? {
        do {
            let items = try viewContext.fetch(request)
            return items
        }
        catch {
            print ("Error fetching items from context: \(error.localizedDescription)")
        }
        
        return nil
    }
}

