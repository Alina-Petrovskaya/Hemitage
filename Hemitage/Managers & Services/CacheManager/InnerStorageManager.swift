//
//  InnerStorageManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 24.05.2021.
//

import Foundation
import Network

protocol FileManagerProtocol {
    var callback: ((Result<Data, Error>) -> ())? { get set }
    
    /**
     The result of function returns in the "callback" closure
     
     - parameter documentID: Need to build the file path
     - parameter imageName: Need to find difference between the images
     - parameter typeOfChange: Need to determine the type of action: CRUD
     - parameter directory: Optional parameter need to download image from storage
     */
    func getImageData(with documentID: String, imageName: String, for typeOfChange: TypeOfChangeDocument, from directory: StorageDirectory?, completion: @escaping (Data) -> ())
    
    func manageSongData(songURL: URL, requestType: RequestType)
    
    func isSavedSong(for url: URL) -> Bool
}


class InnerStorageManager: FileManagerProtocol {
    
    var callback: ((Result<Data, Error>) -> ())?
    
    private let monitor = NWPathMonitor()
    private let fileManager = FileManager.default
    private let firebaseStorage: FirebaseStorage = FirebaseStorageManager()
    private var urlToGet: URL?
    private var urlToSave: Set<URL> = []
    
    private var internetStatus: NWPath.Status = .unsatisfied {
        didSet {
            if oldValue != internetStatus, internetStatus == .satisfied {
                
                if urlToGet != nil {
                    getSongItem(with: urlToGet!)
                }
                
                if urlToSave.count != 0 {
                    saveSongs(with: Array(urlToSave))
                }
            }
        }
    }
    
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.internetStatus = path.status
        }
        
        let queue = DispatchQueue.global()
        monitor.start(queue: queue)
    }
    
    // MARK: - Manage images
    func getImageData(with document: String, imageName: String, for typeOfChange: TypeOfChangeDocument, from directory: StorageDirectory? = nil,
                      completion: @escaping (Data) -> ()) {
        
        guard let path = getPath(with: document) else { print("Can't create path to image storage"); return }
        
        switch typeOfChange {
        case .added, .modified:
            
            guard let data = decodeData(with: path, model: ImageManagerModel.self),
                  data.imageName == imageName  else {
                
                if let storageDirectory = directory { // get new data from storage
                    
                    firebaseStorage.getData(fileName: imageName, from: storageDirectory) { [weak self] data in
                        completion(data)
                        
                        let imageModel = ImageManagerModel(imageName: imageName, imageData: data)
                        let modelData  = self?.encodeData(with: imageModel)
                        
                        try? modelData?.write(to: path)
                    }
                }
                return
            }
            
            // Return current image
            let imageData = data.imageData
            completion(imageData)
            
            
        case .removed:
            try? fileManager.removeItem(at: path)
        }
    }
    
    
    // MARK: - Manage songs
    func manageSongData(songURL: URL, requestType: RequestType) {
        guard let path = getPath(with: songURL.absoluteString) else { print("Can't create path to song storage"); return }
        
        switch requestType {
        case .save:
            saveSongs(with: [songURL])
            
        case .get:
            getSongItem(with: songURL)
            
        case .delete:
            print("Song removed")
            try? fileManager.removeItem(at: path)
            urlToSave.remove(songURL)
        }
    }
    
    
    func getSongItem(with url: URL) {
        if let savedData = decodeData(with: url, model: SongManagerModel.self) {
            urlToGet = nil
            callback?(.success(savedData.songData))
            
        } else {
            if internetStatus == .satisfied {
                firebaseStorage.getDataWithURL(url) { [weak self] result in
                    switch result {
                    
                    case .success(let loadedData):
                        self?.callback?(.success(loadedData))
                        self?.urlToGet = nil
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                        self?.urlToGet = url
                    }

                }
            }
        }
    }
    
    
    func saveSongs(with urls: [URL]) {
        urls.forEach { url in
            
            if internetStatus == .satisfied {
                guard let path = getPath(with: url.absoluteString) else { print("Can't create path to song storage"); return }
                
                firebaseStorage.getDataWithURL(url) { [weak self] result in
                    switch result {
                    
                    case .success(let loadedData):
                        let item = SongManagerModel(songUrl: url, songData: loadedData)
                        let dataToSave = self?.encodeData(with: item)
                        
                        try? dataToSave?.write(to: path)
                        self?.urlToSave.remove(url)
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    
                }
            } else {
                urlToSave.insert(url)
            }
        }
    }
    
    func isSavedSong(for url: URL) -> Bool {
        guard let path = getPath(with: url.absoluteString)?.path else { return false }
        if fileManager.fileExists(atPath: path) {
            return true
        }
        
        return false
    }
    
 // MARK: - Decode / Encode Data
    private func getPath(with documentID: String) -> URL? {
        
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                 in: .userDomainMask).first else { return nil }
        
        let path = documentURL.appendingPathComponent(documentID)
        return path
    }
    
    
    private func decodeData<T: Codable>(with path: URL, model: T.Type) -> T? {
        
        if let data = try? Data(contentsOf: path) {
            
            let decoder = PropertyListDecoder()
            
            do {
                let imageData = try decoder.decode(model, from: data)
                return imageData
                
            } catch {
                print("Error at reading data: \(error.localizedDescription)")
            }
        }
        return nil
    }
    
    
    
    private func encodeData<T: Codable>(with model: T) -> Data? {
        
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
