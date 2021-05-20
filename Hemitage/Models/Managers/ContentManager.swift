//
//  ContentManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 20.05.2021.
//

import Foundation

protocol ContentManagerProtocol {
    
}

class ContentManager {
    lazy var fireBaseManager: FireStoreDataManagerProtocol = FireStoreCacheDataManager()
    lazy var coreDataManager = DataStoreManager()
    
    
    var callback: (() -> ())?
}
