//
//  ImageCacheManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 21.05.2021.
//

import UIKit

class ImageCacheManager  {
    
    static let shared = ImageCacheManager()
    
    let cache = NSCache<NSString, NSData>()
    let storageManager: FirebaseStorage = FirebaseStorageManager()
    
    
    func cacheObject(imageName: String, documentID: String, from category: StorageDirectory, completion: @escaping (Data?) -> ())  {
        
        cache.name = "Images"
        
        if let object = cache.object(forKey: "\(documentID)\(imageName)" as NSString) {
            completion(object as Data?)
            
        } else {
            getImageData(with: imageName) { [weak self] imageData in
                if let safeData = imageData as NSData? {
                    self?.cache.setObject(safeData, forKey: "\(documentID)\(imageName)" as NSString)
                }
                
                completion(imageData)
            }
        }
    }
    
    
    
    private func getImageData(with imageName: String, completion: @escaping (Data?) -> ()) {
        
        storageManager.getData(fileName: imageName, from: .blog) { result in
            switch result {
            case .success(let data):
                completion(data)
                
            case .failure(let error):
                print("Can't get image data with error \(error.errorDescription)")
                completion(nil)
            }
        }
    }
}
