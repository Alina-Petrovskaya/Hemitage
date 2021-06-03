//
//  ImageFileManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 24.05.2021.
//

import Foundation
import Network

protocol ImageFileManagerProtocol {
    var callback: ((Data) -> ())? { get set }
    
    /**
     The result of function returns in the "callback" closure
     
     - parameter documentID: Need to build the file path
     - parameter imageName: Need to find difference between the images
     - parameter typeOfChange: Need to determine the type of action: CRUD
     - parameter directory: Optional parameter need to download image from storage
     */
    func getData(with documentID: String, imageName: String, for typeOfChange: TypeOfChangeDocument, from directory: StorageDirectory?, completion: @escaping (Data) -> ())
}


class ImageFileManager: ImageFileManagerProtocol {
    
    var callback: ((Data) -> ())?
    private let monitor = NWPathMonitor()
    private let fileManager = FileManager.default
    private let firebaseStorage: FirebaseStorage = FirebaseStorageManager()
    
    private var internetStatus: NWPath.Status = .unsatisfied
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.internetStatus = path.status
        }
        
        let queue = DispatchQueue.global()
        monitor.start(queue: queue)
    }


    func getData(with documentID: String,
                 imageName: String,
                 for typeOfChange: TypeOfChangeDocument,
                 from directory: StorageDirectory? = nil,
                 completion: @escaping (Data) -> ()) {
        
        guard let path = getPath(with: documentID)
        else {
            print("Can't create path to image storage")
            return
        }
              
        
        switch typeOfChange {
        
        case .added, .modified:
            guard let data = decodeData(with: path),
                  data.imageName == imageName  else {
                
                if let storageDirectory = directory { // get new data from storage
                    getDataFromStorage(imageName: imageName, at: storageDirectory) { [weak self] data in
                        
                        completion(data)
                        
                        let imageModel = ImageManagerModel(imageName: imageName, imageData: data)
                        let modelData  = self?.encodeData(with: imageModel)
                        
                        try? modelData?.write(to: path)
                        print("Image aded")
                    }
                }
                return
            }
            
            
            // Return current image
            let imageData = data.imageData
            print("Image found")
            completion(imageData)
            
            
            
        case .removed:
            print("Image removed")
            try? fileManager.removeItem(at: path)
        }
    }
    

    
    private func getDataFromStorage(imageName: String, at directory: StorageDirectory, completion: @escaping (Data) -> ()) {

        if internetStatus == .satisfied {
            firebaseStorage.getData(fileName: imageName, from: directory) { result in
                switch result {
                
                case .success(let data):
                    completion(data)
                    
                case .failure(let error):
                    print("Can't get image with error \(error.errorDescription ?? "nil")")
                }
            }
        }
    }
    
    
    private func getPath(with documentID: String) -> URL? {
        
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                in: .userDomainMask).first else { return nil }
        
        let path = documentURL.appendingPathComponent(documentID)
        return path
    }
    
    
    private func decodeData(with path: URL) -> ImageManagerModel? {
        
        if let data = try? Data(contentsOf: path) {
            
            let decoder = PropertyListDecoder()
            
            do {
                let imageData = try decoder.decode(ImageManagerModel.self, from: data)
                return imageData
                
            } catch {
                print("Error at reading data: \(error.localizedDescription)")
            }
        }
        return nil
    }
    
    
    
    private func encodeData(with model: ImageManagerModel) -> Data? {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(model)
            return data
            
        } catch {
            print("Error at converting data: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    deinit {
       monitor.cancel()
    }
}
