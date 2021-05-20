//
//  FireStoreDataManagerProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 19.05.2021.
//

import FirebaseFirestore

protocol FireStoreDataManagerProtocol {
    
    var callBack: (((data: AnyHashable, typeOfChange: FireStoreTypeOfChangeDocument, collection: FireStoreCollectionName)) -> ())? { get set }
    
    func fetchData(from collection: FireStoreCollectionName)
    
}
