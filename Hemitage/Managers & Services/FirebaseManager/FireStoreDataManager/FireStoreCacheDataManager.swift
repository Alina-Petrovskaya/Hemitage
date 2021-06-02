//
//  FireStoreCacheDataManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 17.05.2021.
//
import Foundation
import FirebaseFirestore

protocol FireStoreDataManagerProtocol {
    
    var callBack: (((data: [AnyHashable], typeOfChange: TypeOfChangeDocument, collection: FireStoreCollectionName)) -> ())? { get set }
    
    func fetchData<T: Codable & Hashable>(from collection: FireStoreCollectionName, with model: T.Type)
    func queryItem<T: Codable & Hashable>(from collection: FireStoreCollectionName, by id: String, with model: T.Type, completion: @escaping (T) -> ())
}

class FireStoreCacheDataManager: FireStoreDataManagerProtocol {
    var callBack: (((data: [AnyHashable], typeOfChange: TypeOfChangeDocument, collection: FireStoreCollectionName)) -> ())?
    private let db = Firestore.firestore()
    
    
    
    func fetchData<T: Codable & Hashable>(from collection: FireStoreCollectionName, with model: T.Type) {
        db.collection(collection.rawValue).addSnapshotListener(includeMetadataChanges: true) { [weak self] querySnapshot, error in
            
            guard let snapshot = querySnapshot else { return }
            
            snapshot.documentChanges.forEach { [weak self] documentChange in
                guard let changeType = TypeOfChangeDocument(rawValue: documentChange.type.rawValue) else { return }
                
                do {
                    if let data = try documentChange.document.data(as: model) {
                        self?.callBack?((data: [data], typeOfChange: changeType, collection: collection))
                    }
                    
                } catch {
                    print("can't parse data")
                }
            }
        }
    }
    
    
    
    
    func queryItem<T: Codable & Hashable>(from collection: FireStoreCollectionName, by id: String, with model: T.Type, completion: @escaping (T) -> ()) {
        db.collection(collection.rawValue).document(id).getDocument { snapshot, error in
            guard let safeSnapshot = snapshot else { return }
            
            do {
                if let data = try safeSnapshot.data(as: model) {
                    completion(data)
                }
                
            } catch {
                print("can't parse data")
            }
        }
    }
    
}
