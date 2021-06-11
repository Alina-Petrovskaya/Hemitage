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
    var imageManager: ImageFileManagerProtocol = ImageFileManager()
    
    let sdsdsf = (2, "")
    let sddsf = (3, "4")

   
    
    func cacheImageObject(imageName: String,
                     documentID: String,
                     from category: StorageDirectory,
                     typeOFUpdate: TypeOfChangeDocument,
                     completion: @escaping ((imageData: Data?, typeOfCahnge: TypeOfChangeDocument)) -> ())  {
        
        let object = cache.object(forKey: "\(documentID)\(imageName)" as NSString)
        completion((imageData: object as Data?, typeOfCahnge: typeOFUpdate))
        
        if object == nil || typeOFUpdate == .removed {
            
            imageManager.getData(with: documentID, imageName: imageName, for: typeOFUpdate, from: category) { [weak self] result in
                
                completion((imageData: result, typeOfCahnge: .modified))
                self?.cache.setObject(result as NSData, forKey: "\(documentID)\(imageName)" as NSString)
                
            }
        }
    }
    
    
}
