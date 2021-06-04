//
//  CategoriesCollectionViewCellModelView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 13.05.2021.
//

import Foundation
import Network

class CategoriesCollectionViewCellModelView: MainScreenCollectionViewCellModelViewProtocol, Hashable {
    
    let id: String
    private var imageURL: URL?
    private var title: String
    
    init(id: String, title: String, imageURL: URL?) {
        self.id       = id
        self.imageURL = imageURL
        self.title    = title
    }
    
    
    func updateContent<T>(with data: T) {
        guard let safeData = data as? (id: String, imageURL: URL?, title: String) else { return }
        imageURL = safeData.imageURL
        title    = safeData.title
    }
    
    
    func getData<T>() -> T {
        guard let returnData = (id: id, imageURL: imageURL, title: title) as? T else {
            fatalError("Can't return data for Categories row")
        }
        return returnData
    }
    
    static func == (lhs: CategoriesCollectionViewCellModelView, rhs: CategoriesCollectionViewCellModelView) -> Bool {
        return lhs.id == rhs.id && lhs.imageURL == rhs.imageURL
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
