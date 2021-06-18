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
    func fetchDataFromSubcollection<T: Codable & Hashable>(from collection: FireStoreCollectionName, with model: T.Type, document id: String)
    /**
     Query item by document id
     */
    func queryItemByID<T: Codable & Hashable>(_ id: String, from collection: FireStoreCollectionName, model: T.Type, completion: @escaping (T) -> ())
    
    /**
     Query items by  value  at specific field
     */
    func queryItems<T: Codable & Hashable>(queryData: QueryData, from collection: FireStoreCollectionName, model: T.Type,completion: @escaping ([T]) -> ())
}
