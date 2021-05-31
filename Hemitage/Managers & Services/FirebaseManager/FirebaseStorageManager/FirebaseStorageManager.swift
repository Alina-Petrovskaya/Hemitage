//
//  FirebaseStorageManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 14.05.2021.
//

import Foundation
import FirebaseStorage

protocol FirebaseStorage {
    
    func getData(fileName: String, from directory: StorageDirectory, completion: ((Result<Data, FirebaseError>) -> ())?)
    func getPathToFile(fileName: String, at directory: StorageDirectory, completion: @escaping (Result<URL, FirebaseError>) -> ())
}


class FirebaseStorageManager: FirebaseStorage {
    
    private let storage = Storage.storage()
    
    func getData(fileName: String, from directory: StorageDirectory, completion: ((Result<Data, FirebaseError>) -> ())?) {
        let childPath     = "\(directory.rawValue)/\(fileName)"
        let pathReference = storage.reference()
        let fileReference = pathReference.child(childPath)
        
        fileReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                completion?(.failure(.unableToDownloadFileFromStorage))
                
            } else if let safeData = data {
                completion?(.success(safeData))
            }
        }
    }
    
    func getPathToFile(fileName: String, at directory: StorageDirectory, completion: @escaping (Result<URL, FirebaseError>) -> ()) {
        let childPath     = "\(directory.rawValue)/\(fileName)"
        let pathReference = storage.reference()
        let fileReference = pathReference.child(childPath)
        
        fileReference.downloadURL { url, error in
            guard error == nil, let url = url
            else {
                completion(.failure(.unableToCreateURLToFileInStorage))
                return
            }
           
            completion(.success(url))
        }
    }
}
