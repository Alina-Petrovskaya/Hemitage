//
//  FireStoreReadDataManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 17.05.2021.
//
import Foundation
import FirebaseFirestore


class FireStoreReadDataManager: FireStoreDataManagerProtocol {
    
    private let db = Firestore.firestore()
    var callBack: (((data: [AnyHashable], typeOfChange: TypeOfChangeDocument, collection: FireStoreCollectionName)) -> ())?
    
    
    func fetchData<T: Codable & Hashable>(from collection: FireStoreCollectionName, with model: T.Type) {
        
        fetchDocuments(with: model, collectionReference: db.collection(collection.rawValue)) { [weak self] result in
            self?.callBack?((data: result.items, typeOfChange: result.changeType, collection: collection))
        }
    }
    
    
    func fetchDataFromSubcollection<T: Codable & Hashable>(from collection: FireStoreCollectionName, with model: T.Type, document id: String) {
        let mainCollection = collection.rawValue
        guard let subcollection = collection.getSubcollectionName() else { return }
        
        fetchDocuments(with: model, collectionReference: db.collection(mainCollection).document(id).collection(subcollection) ) { [weak self] result in
            self?.callBack?((data: result.items, typeOfChange: result.changeType, collection: collection))
        }
    }

    func queryItems<T: Codable & Hashable>(from collection: FireStoreCollectionName,
                                           field: String,
                                           value: String,
                                           using model: T.Type,
                                           sortField: String,
                                           completion: @escaping ([T]) -> ()) {

        db.collection(collection.rawValue).whereField(field, arrayContains: value).limit(to: 1).order(by: sortField)
            .getDocuments { [weak self] querySnapshot, error in

                if let error = error {
                    print(error)
                }

                guard let snapshot = querySnapshot
                else {

                    return

                }

                guard let lastSnapshot = snapshot.documents.last else {
                    print("Error in creating last snaphot")
                    return
                }

                self?.db.collection(collection.rawValue).whereField(field, arrayContains: value).limit(to: 10).order(by: sortField).start(afterDocument: lastSnapshot)
                    .getDocuments { querySnapshot, error in

                        if let error = error {
                            print(error)
                        }

                        guard let snapshot = querySnapshot else {
                            print("Error in creating snaphot")
                            return }

                        let items = snapshot.documents.compactMap { [weak self] documentChange -> T? in
                            let data = self?.decodeQueryDocument(with: model, documentSnapshot: documentChange)

                            return data
                        }
                        completion(items)
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
    
    
    private func fetchDocuments<T: Codable & Hashable> (with model: T.Type,
                                                        collectionReference: CollectionReference,
                                                        completion: @escaping ((items: [T], changeType: TypeOfChangeDocument)) -> ()) {
        
        collectionReference.addSnapshotListener(includeMetadataChanges: true) { querySnapshot, error in
            guard let snapshot = querySnapshot else { return }
            
            snapshot.documentChanges.forEach { [weak self] documentChange in
                if let item = self?.decodeQueryDocument(with: model, documentSnapshot: documentChange.document),
                   let changetype = TypeOfChangeDocument.init(rawValue: documentChange.type.rawValue) {
                    
                    completion((items: [item], changeType: changetype))
                }
            }
        }
    }
    
    
    private func decodeQueryDocument<T: Codable & Hashable>(with model: T.Type, documentSnapshot: QueryDocumentSnapshot) -> T? {
        do {
            if let data = try documentSnapshot.data(as: model) {
                return data
            }
        } catch {
            print("can't parse data")
        }
        return nil
    }
    
}
