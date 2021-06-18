//
//  FireStoreReadDataManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 17.05.2021.
//
import Foundation
import FirebaseFirestore

typealias QueryData = (requestData: [(field: String, value: Any)], sortField: String, currentNumberOfItems: Int)


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
    
    
    func queryItems<T: Codable & Hashable>(queryData: QueryData, from collection: FireStoreCollectionName, model: T.Type,completion: @escaping ([T]) -> ()) {
        let collectionReference = db.collection(collection.rawValue)

        guard let query = queryData.requestData.getQuery(for: collectionReference)?
                .order(by: queryData.sortField, descending: true)
        else { return }
        
//        let query = db.collection(collection.rawValue).whereField(queryData.requestData[0].field, arrayContains: queryData.requestData[0].value).whereField(queryData.requestData[1].field, isEqualTo: queryData.requestData[1].value)
     
        guard queryData.currentNumberOfItems != 0
        else {
            fetchQuery(with: model, query: query.limit(to: 10)) { completion($0) }
            return
        }
        
        query.limit(to: queryData.currentNumberOfItems).getDocuments { [weak self] querySnapshot, error in
            guard let snapshot = querySnapshot,
                  let lastSnapshot = snapshot.documents.last else { return }
            
            let newQuery = query.limit(to: 10).start(afterDocument: lastSnapshot)
            self?.fetchQuery(with: model, query: newQuery) { completion($0) }
        }
    }
    
    
    func queryItemByID<T: Codable & Hashable>(_ id: String, from collection: FireStoreCollectionName, model: T.Type, completion: @escaping (T) -> ()) {
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
    
    
    private func fetchQuery<T: Codable & Hashable>(with model: T.Type, query: Query, completion: @escaping ([T]) -> ()) {
        query.getDocuments { querySnapshot, error in
            guard let snapshot = querySnapshot else { return }
            
            let items = snapshot.documents.compactMap { [weak self] documentSnaphot -> T? in
                return self?.decodeQueryDocument(with: model, documentSnapshot: documentSnaphot)
            }
            
            completion(items)
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
