//
//  FireStoreCacheDataManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 17.05.2021.
//
import Foundation
import FirebaseFirestore

class FireStoreCacheDataManager: FireStoreDataManagerProtocol {
    var callBack: (((data: [AnyHashable], typeOfChange: TypeOfChangeDocument, collection: FireStoreCollectionName)) -> ())?
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
        snapshot.documentChanges.forEach { [weak self] documentChange  in
            
            switch collection {
            case .categories:
                
                if let changeType = TypeOfChangeDocument(rawValue: documentChange.type.rawValue),
                   let data = parseData(with: documentChange.document, model: CategoriesModel.self) {
                    
                    self?.callBack?((data: [data], typeOfChange: changeType, collection: collection))
                }
                
            case .blog:
                break
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
