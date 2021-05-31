//
//  FireStoreDataManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 19.05.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

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
            
            switch collection {
            case .categories:
                break
                
            case .blog:
                
                if let changeType = TypeOfChangeDocument(rawValue: documentChange.type.rawValue),
                   let data = parseData(with: documentChange.document, model: BlogModel.self) {
                    
                    self?.callBack?((data: [data], typeOfChange: changeType, collection: collection))
                }
            }
        }
        
    }
    
    
    private func parseData<T: Codable>(with snapshot: QueryDocumentSnapshot, model: T.Type) -> T? {
        do {
            let data = try snapshot.data(as: model)
            return data
            
        } catch {
            print("can't parse data")
        }
        
        return nil
    }

}
