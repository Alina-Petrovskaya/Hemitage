//
//  FirebaseStorageManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 14.05.2021.
//

import Foundation
import FirebaseStorage

protocol FirebaseStorage {
    
    func getData(fileName: String, from directory: StorageDirectory, completion: @escaping (Data) -> ())
    func getPathToFile(fileName: String, at directory: StorageDirectory, completion: @escaping (Result<URL, FirebaseError>) -> ())
    func getDataWithURL(_ url: URL, completion: @escaping (Result<Data, Error>) -> ())
}


class FirebaseStorageManager: FirebaseStorage {
    
    private let storage = Storage.storage()
    
    func getData(fileName: String, from directory: StorageDirectory, completion: @escaping (Data) -> ()) {
        let childPath     = "\(directory.rawValue)/\(fileName)"
        let pathReference = storage.reference()
        let fileReference = pathReference.child(childPath)
        
        fileReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                print(error!.localizedDescription)
                
            } else if let safeData = data {
                completion(safeData)
            }
        }
    }
    
    
    func getDataWithURL(_ url: URL, completion: @escaping (Result<Data, Error>) -> ()) {
        let path = storage.reference(forURL: "https://firebasestorage.googleapis.com/v0/b/hemitage-60f4a.appspot.com/o/SongsData%2FSongs%2FJust_Because_-_Martin_Dupont.mp3?alt=media&token=c0c7df1a-866e-4d5a-8051-a9306e720edb")
        
        path.getData(maxSize: 15 * 1024 * 1024) { data, error in
            guard error == nil else {
                completion(.failure(error!))
                
                return
            }
            
            guard let safeData = data else { return }
            completion(.success(safeData))
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
