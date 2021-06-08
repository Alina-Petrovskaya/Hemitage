//
//  ReadContentManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 20.05.2021.
//

import Foundation
import CoreData


protocol ReadContentManagerProtocol {
    associatedtype DBManager
    
    var callback: (((data: [AnyHashable], typeOfChange: TypeOfChangeDocument, collection: FireStoreCollectionName)) -> ())? { get set }
    
    /**
     Requests content based on storage type.
     
     - parameter collection: Database collection from which data will be requested
     - parameter dbManager: Name of the field in which to search for the value. If left as nil, the value will be taken as the ID of the document
     - returns: Data will be returned to callback
     */
    func getContent<T: Codable & Hashable>(from collection: FireStoreCollectionName, with dbManager: DBManager, codableModel: T.Type)
    func getItemsFromSubgroup<T: Hashable & Codable>(from collection: FireStoreCollectionName, with model: T.Type, document id: String)
    /**
     Query items by value without listening of changes
     - parameter value: The parameter can act as a field value or as a document ID
     - parameter field: Optional
     - returns:  Data will be returned in completion -> Item or number of Items
     */
    func queryItemsFromFirebase<T: Hashable & Codable>(value: String,
                                                      field: String?,
                                                      from collection: FireStoreCollectionName,
                                                      with model: T.Type,
                                                      sortField: String?,
                                                      completion: @escaping ([T]) -> ())
}


class ReadContentManager: NSObject, NSFetchedResultsControllerDelegate, ReadContentManagerProtocol {
    
    enum DBManager {
        case fireBaseManager, coreDataManager
    }
    
    var callback: (((data: [AnyHashable], typeOfChange: TypeOfChangeDocument, collection: FireStoreCollectionName)) -> ())?
    
    private lazy var fireBaseManager: FireStoreDataManagerProtocol = FireStoreReadDataManager()
    private lazy var fetchedResultsBlog = NSFetchedResultsController(
        fetchRequest: DataStoreManager.shared.createRequest(from: .blog, sortByField: "date"),
        managedObjectContext: DataStoreManager.shared.viewContext,
        sectionNameKeyPath: nil,
        cacheName: nil)
    
    override init() {
        super.init()
        catchCallbackFromFirebase()
    }
    
    func getContent<T: Codable & Hashable>(from collection: FireStoreCollectionName, with dbManager: DBManager, codableModel: T.Type) {
        switch dbManager {
        case .fireBaseManager:
            manageContentWithFirebase(from: collection,with: codableModel)
            
            
        case .coreDataManager:
            DataStoreManager.shared.getAllItems(from: collection) { [weak self] data in
                self?.callback?((data: data, typeOfChange: .added, collection: collection))
            }
            
            manageContentWithInnerBase(from: collection)
        }
    }

    
    // MARK: - Manage Firebase Data Content
    private func catchCallbackFromFirebase() {
        fireBaseManager.callBack = { [weak self] result in
            self?.callback?(result)
        }
    }
    
    private func manageContentWithFirebase<T: Codable & Hashable>(from collection: FireStoreCollectionName, with model: T.Type) {
        fireBaseManager.fetchData(from: collection, with: model)
    }
    
    
    func getItemsFromSubgroup<T: Hashable & Codable>(from collection: FireStoreCollectionName, with model: T.Type, document id: String) {
        fireBaseManager.fetchDataFromSubcollection(from: collection, with: model, document: id)
        
    }
    
    
    
    func queryItemsFromFirebase<T: Hashable & Codable>(value: String,
                                                      field: String? = nil,
                                                      from collection: FireStoreCollectionName,
                                                      with model: T.Type,
                                                      sortField: String?,
                                                      completion: @escaping ([T]) -> ()) {
        guard let safeField = field,
              let by = sortField
        else {
            fireBaseManager.queryItem(from: collection, by: value, with: model) { item in
                completion([item])
            }
            return
        }
        
        fireBaseManager.queryItems(from: collection, field: safeField, value: value, using: model, sortField: by) { items in
            completion(items)
        }
    }
    
    
    // MARK: - Manage Core Data Content
    private func manageContentWithInnerBase(from collection: FireStoreCollectionName) {
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
                
            default:
               break
            }
        }
    }
}
