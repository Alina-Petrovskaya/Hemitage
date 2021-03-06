//
//  CacheManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 21.05.2021.
//

import UIKit


class Cache: NSCache<NSString, NSData> {
    static let shared = NSCache<NSString, NSData>()
    
    private override init() {
        super.init()
        self.name = "Images"
    }
}


class CacheManager {
    
    private let cache = Cache.shared
    private var storageManager: FileManagerProtocol = InnerStorageManager()
    
    
    func cacheImageObject(imageName: String,
                     documentID: String,
                     from category: StorageDirectory,
                     typeOFUpdate: TypeOfChangeDocument,
                     completion: @escaping ((imageData: Data?, typeOfCahnge: TypeOfChangeDocument)) -> ())  {
        
        let object = cache.object(forKey: "\(documentID)\(imageName)" as NSString)
        completion((imageData: object as Data?, typeOfCahnge: typeOFUpdate))
        
        if object == nil || typeOFUpdate == .removed {
            
            storageManager.getImageData(with: documentID, imageName: imageName, for: typeOFUpdate, from: category) { [weak self] result in
                
                completion((imageData: result, typeOfCahnge: .modified))
                self?.cache.setObject(result as NSData, forKey: "\(documentID)\(imageName)" as NSString)
                
            }
        }
    }
    
    
    func manageSongSaving(songURL: URL, documentID: String, completion: @escaping (Bool) -> ()) {
        storageManager.manageSongSaving(id: documentID, url: songURL, isSaved: completion)
    }
    
    func cacheSongObject(songURL: URL, documentID: String, completion: ((Result<Data, Error>) -> ())?) {
        let dataSong = cache.object(forKey: "\(songURL.absoluteString)" as NSString) as Data?
        
        if dataSong != nil {
            completion?(.success(dataSong!))
            
        } else {
            storageManager.callback = { [weak self] result in
                switch result {
                
                case .success(let data):
                    completion?(.success(data))
                    self?.cache.setObject(data as NSData, forKey: "\(songURL.absoluteString)" as NSString)
                    
                case .failure(let error):
                    completion?(.failure(error))
                }
            }
            
            storageManager.getSongItem(for: documentID, url: songURL)
        }
    }
    
    
    func isSongSaved(docimentID: String) -> Bool {
        return storageManager.isSavedSong(for: docimentID)
    }
    
}
