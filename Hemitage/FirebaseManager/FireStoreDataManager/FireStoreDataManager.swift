//
//  FireStoreDataManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 19.05.2021.
//

import Foundation
import FirebaseFirestore

class FireStoreDataManager: FireStoreDataManagerProtocol {
    
var callBack: (((data: AnyHashable, typeOfChange: DocumentChangeType, collection: FireStoreTypeOfCollection)) -> ())?
private let db = Firestore.firestore()

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
            break
            
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
}
