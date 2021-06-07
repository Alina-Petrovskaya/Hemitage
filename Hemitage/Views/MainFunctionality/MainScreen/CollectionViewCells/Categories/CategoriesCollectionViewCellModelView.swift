//
//  CategoriesCollectionViewCellModelView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 13.05.2021.
//

import Foundation
import Network

class CategoriesCollectionViewCellModelView: MainScreenCollectionViewCellModelViewProtocol, Hashable {
    typealias DataType = (id: String, imageURL: URL?, title: String)
    
    let id: String
    private var imageURL: URL?
    private var title: String
    
    init(model: CategoriesModel) {
        self.id       = model.id ?? "nill"
        self.imageURL = model.imageURL
        self.title    = model.name
    }
    
    
    func updateContent<T: MainScreenCollectionViewCellModelViewProtocol>(with data: T) {
        guard let data: DataType = data.getData() else { return }
        imageURL = data.imageURL
        title    = data.title
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
