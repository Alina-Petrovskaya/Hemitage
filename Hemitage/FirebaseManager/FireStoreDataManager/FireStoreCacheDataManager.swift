//
//  FireStoreCacheDataManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 17.05.2021.
//
import Foundation
import FirebaseFirestore

class FireStoreCacheDataManager: FireStoreDataManagerProtocol {
    var callBack: (((data: AnyHashable, typeOfChange: FireStoreTypeOfChangeDocument, collection: FireStoreCollectionName)) -> ())?
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
    
    
    func fetchData(from collection: FireStoreCollectionName) {
        db.collection(collection.rawValue).addSnapshotListener(includeMetadataChanges: true) { [weak self] querySnapshot, error in
            guard let snapshot = querySnapshot else { return }
            
            self?.getData(with: snapshot, from: collection)
        }
    }
    
    
    private func getData(with snapshot: QuerySnapshot, from collection: FireStoreCollectionName) {
        _ = snapshot.documentChanges.compactMap { [weak self] documentChange -> AnyHashable? in
            let data = documentChange.document.data()
            
            switch collection {
            case .categories:
                self?.parseCategoryData(with: data, documentId: documentChange.document.documentID) { model in
                    if let changeType = FireStoreTypeOfChangeDocument(rawValue: documentChange.type.rawValue) {
                        self?.callBack?((data: model, typeOfChange: changeType, collection: collection))
                    }
                }
                
            case .blog:
                break
            }
            
            return nil
        }
    }
    
    
    private func parseCategoryData(with data: [String : Any], documentId: String, completion: @escaping (CategoriesModel) -> ()) {
        guard let name      = data["name"] as? String,
              let imageName = data["imageName"] as? String,
              let imageUrl  = data["imageURL"] as? String
        else { return }
        
        if let url = URL(string: imageUrl) {
            let data = CategoriesModel(id: documentId, imageURL: url, imageName: imageName, name: name)
            completion(data)
        } else {
            let model = CategoriesModel(id: documentId, imageURL: nil, imageName: imageName, name: name)
            completion(model)
        }
    }
}
