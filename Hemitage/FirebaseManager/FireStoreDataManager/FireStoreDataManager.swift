//
//  FireStoreDataManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 17.05.2021.
//

import Foundation
import FirebaseFirestore
import Network

protocol FireStoreDataManagerProtocol {
    
    var callBack: (((data: AnyHashable, typeOfChange: DocumentChangeType, collection: FireStoreTypeOfCollection)) -> ())? { get set }
    
    func fetchData(from collection: FireStoreTypeOfCollection)
    
}


class FireStoreDataManager: FireStoreDataManagerProtocol {
    var callBack: (((data: AnyHashable, typeOfChange: DocumentChangeType, collection: FireStoreTypeOfCollection)) -> ())?
    private let db = Firestore.firestore()
    
    init() {
        let settings                  = FirestoreSettings()
        settings.isPersistenceEnabled = true
        db.settings                   = settings
        
        configureCacheSize()
    }
    
    
    private func configureCacheSize() {
        let settings = Firestore.firestore().settings
        settings.cacheSizeBytes = FirestoreCacheSizeUnlimited
        Firestore.firestore().settings = settings
    }
    
    
    func fetchData(from collection: FireStoreTypeOfCollection) {
        
        db.collection(collection.rawValue).addSnapshotListener(includeMetadataChanges: true) { [weak self] querySnapshot, error in
            guard let snapshot = querySnapshot else { return }
            
            self?.getData(with: snapshot, from: collection)
        }
    }
    
    
    private func getData(with snapshot: QuerySnapshot, from collection: FireStoreTypeOfCollection) {
        _ = snapshot.documentChanges.compactMap { [weak self] documentChange -> AnyHashable? in
            let data = documentChange.document.data()
            
            switch collection {
            case .categories:
                self?.parseCategoryData(with: data, documentId: documentChange.document.documentID) { model in
                    if let model = model {
                        self?.callBack?((data: model, typeOfChange: documentChange.type, collection: collection))
                    }
                }
                
            case .blog:
                break
            }
            
            return nil
        }
    }
    
    
    private func parseCategoryData(with data: [String : Any], documentId: String, completion: @escaping (CategoriesModel?) -> ()) {
        guard let name      = data["name"] as? String,
              let imageName = data["imageName"] as? String,
              let imageUrl  = data["imageURL"] as? String
        else { return completion(nil)}
        
        if let url = URL(string: imageUrl) {
            let data = CategoriesModel(id: documentId, imageURL: url, imageName: imageName, name: name)
            completion(data)
        } else {
            let model = CategoriesModel(id: documentId, imageURL: nil, imageName: imageName, name: name)
            completion(model)
        }
    }
    
    
    private func parseBlogData(with data: [String : Any]) -> AnyHashable? {
        
        return BlogModel(id: "1", imageName: "22", title: "3443", preview: "3443", date: "3434", text: "343434")
    }
}
