//
//  ContentManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 20.05.2021.
//

import Foundation
import CoreData


protocol ContentManagerProtocol {
    associatedtype DBManager
    
    var callback: (((data: [AnyHashable], typeOfChange: TypeOfChangeDocument, collection: FireStoreCollectionName)) -> ())? { get set }
    
    /**
     Requests content based on storage type.
     
     - parameter collection: Database collection from which data will be requested
     - parameter dbManager: Storage type
     - returns: The data will be returned to callback
     */
    func getContent(from collection: FireStoreCollectionName, with dbManager: DBManager)
}


class ContentManager: NSObject, NSFetchedResultsControllerDelegate {
    
    enum DBManager {
        case fireBaseManager, coreDataManager
    }
    
    var callback: (((data: [AnyHashable], typeOfChange: TypeOfChangeDocument, collection: FireStoreCollectionName)) -> ())?
    
    private lazy var fireBaseManager: FireStoreDataManagerProtocol = FireStoreCacheDataManager()
    private lazy var coreDataManager: CoreDataManager              = DataStoreManager()
    
    private lazy var fetchedResultsBlog = NSFetchedResultsController(
        fetchRequest: coreDataManager.createRequest(from: .blog, sortByField: "date"),
        managedObjectContext: coreDataManager.viewContext,
        sectionNameKeyPath: nil,
        cacheName: nil)
    
    
    func getContent(from collection: FireStoreCollectionName, with dbManager: DBManager) {
        switch dbManager {
        
        case .fireBaseManager:
            manageContentWithFirebase(from: collection)
            
        case .coreDataManager:
            coreDataManager.getAllItems(from: collection) { [weak self] data in
                self?.callback?((data: data, typeOfChange: .added, collection: collection))
            }
            
            manageContentWithInnerBase(from: collection, object: Article.self)
        }
    }
    
    
    
    private func manageContentWithFirebase(from collection: FireStoreCollectionName) {
        fireBaseManager.callBack = { [weak self] result in
            self?.callback?(result)
        }
        
        fireBaseManager.fetchData(from: collection)
    }
    
    
    // MARK: - Manage Core Data Content
    private func manageContentWithInnerBase<T: NSManagedObject>(from collection: FireStoreCollectionName, object: T.Type) {
        fetchedResultsBlog.delegate = self
        
        do {
            try fetchedResultsBlog.performFetch()
        } catch {
            print(error)
        }
    }
    

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        if let blogObject = anObject as? Article {
            switch type {
            case .insert:
                callback?((data: [blogObject], typeOfChange: .added, collection: .blog))
                
            case .delete:
                callback?((data: [blogObject], typeOfChange: .removed, collection: .blog))
                
            case .update:
                callback?((data: [blogObject], typeOfChange: .modified, collection: .blog))
                
            case .move:
                break
                
            @unknown default:
               break
            }
        }
    }
}
