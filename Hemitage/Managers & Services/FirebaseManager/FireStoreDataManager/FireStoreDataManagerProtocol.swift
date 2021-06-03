//
//  FireStoreDataManagerProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 03.06.2021.
//

import Foundation

protocol FireStoreDataManagerProtocol {
    
    var callBack: (((data: [AnyHashable], typeOfChange: TypeOfChangeDocument, collection: FireStoreCollectionName)) -> ())? { get set }
    
    func fetchData<T: Codable & Hashable>(from collection: FireStoreCollectionName, with model: T.Type)
    /**
     Query item by document id
     */
    func queryItem<T: Codable & Hashable>(from collection: FireStoreCollectionName, by id: String, with model: T.Type, completion: @escaping (T) -> ())
    
    /**
     Query items by  value  at specific field
     */
    func queryItems<T: Codable & Hashable>(from collection: FireStoreCollectionName, by field: String, with value: String, using model: T.Type, completion: @escaping ([T]) -> ())
}
