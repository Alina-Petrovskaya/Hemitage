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
                guard let changeType = TypeOfChangeDocument(rawValue: documentChange.type.rawValue),
                      let data = self?.decodeQueryDocument(with: model, snapshot: documentChange.document) else { return }
                
                self?.callBack?((data: [data], typeOfChange: changeType, collection: collection))
            }
        }
    }
    
    
    func queryItem<T: Codable & Hashable>(from collection: FireStoreCollectionName,
                                          by field: String,
                                          value: String,
                                          with model: T.Type,
                                          completion: @escaping ([T]) -> ()) {
        
        db.collection(collection.rawValue)
            .whereField(field, arrayContains: value)
            .limit(to: 20)
            .getDocuments { [weak self] querySnapshot, error in

                guard let snapshot = querySnapshot,
                      let lastSnapshot = snapshot.documents.last
                else { return }
                
                
                //QueryDocumentSnapshot
        }
    }
    
    
    private func decodeQueryDocument<T: Codable & Hashable> (with model: T.Type, snapshot:  QueryDocumentSnapshot) -> T? {

        do {
            if let data = try snapshot.data(as: model) {
                return data
            }
            
        } catch {
            print("can't parse data")
        }

        return nil
    }
    
    
    
    
    func queryItem<T: Codable & Hashable>(from collection: FireStoreCollectionName, by id: String, with model: T.Type, completion: @escaping (T) -> ()) {
        db.collection(collection.rawValue)
            .document(id)
            .getDocument { snapshot, error in
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
