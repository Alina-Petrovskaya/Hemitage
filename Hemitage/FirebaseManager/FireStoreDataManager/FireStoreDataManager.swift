//
//  FireStoreDataManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 19.05.2021.
//

import Foundation
import FirebaseFirestore

class FireStoreDataManager: FireStoreDataManagerProtocol {
    var callBack: (((data: [AnyHashable], typeOfChange: TypeOfChangeDocument, collection: FireStoreCollectionName)) -> ())?
    private let db = Firestore.firestore()
    
    func fetchData(from collection: FireStoreCollectionName) {
        db.collection(collection.rawValue).addSnapshotListener(includeMetadataChanges: false) { [weak self] querySnapshot, error in
            guard let snapshot = querySnapshot else { return }
            self?.getData(with: snapshot, from: collection)
        }
    }
    
    private func getData(with snapshot: QuerySnapshot, from collection: FireStoreCollectionName) {
        snapshot.documentChanges.forEach { [weak self] documentChange in
            let data = documentChange.document.data()
            
            switch collection {
            case .categories:
                break
                
            case .blog:
                
                self?.parseBlogdata(with: data, documentId: documentChange.document.documentID) { model in
                    if let changetype = TypeOfChangeDocument(rawValue: documentChange.type.rawValue) {
                        self?.callBack?((data: [model], typeOfChange: changetype, collection: collection))
                    }
                }
            }
        }
    }
    
    private func parseBlogdata(with data: [String : Any], documentId: String, completion: @escaping (BlogModel) -> ()) {
        guard let title            = data["title"] as? String,
              let subtitle         = data["subtitle"] as? String,
              let previewImageName = data["previewImageName"] as? String,
              let timestamp        = data["date"] as? Timestamp
        else { return }

        completion(BlogModel(id: documentId, previewImageName: previewImageName, title: title, subtitle: subtitle, date: timestamp.dateValue()))
    }
}
