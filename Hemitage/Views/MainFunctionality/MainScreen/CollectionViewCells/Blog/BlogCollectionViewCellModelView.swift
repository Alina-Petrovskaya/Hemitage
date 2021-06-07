//
//  BlogCollectionViewCellModelView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 13.05.2021.
//

import Foundation

class BlogCollectionViewCellModelView: MainScreenCollectionViewCellModelViewProtocol, Hashable {
    typealias ModelData = (id: String, title: String, subtitle: String?, date: String, imageData: Data?)
    
    private let id: String
    private var title: String
    private var subtitle: String?
    private var date: String
    private var imageData: Data?

    init(model: Article, imageData: Data?) {
        self.id         = model.id 
        self.title      = model.title
        self.subtitle   = model.subtitle
        self.date       = model.date.stringRepresentation()
        self.imageData  = imageData
    }
    
    
    func updateContent<T: MainScreenCollectionViewCellModelViewProtocol>(with data: T) {
        guard  let data: ModelData = data.getData() else { return }
        
        self.title      = data.title
        self.subtitle   = data.subtitle
        self.date       = data.date
        self.imageData  = data.imageData
    }
    
    
    func getData<T>() -> T {
        guard let data = (id: id, title: title, subtitle: subtitle, date: date, imageData: imageData) as? T else {
            fatalError("Can't return BlogData")
        }
        
        return data
    }
    
    
    static func == (lhs: BlogCollectionViewCellModelView, rhs: BlogCollectionViewCellModelView) -> Bool {
        return lhs.id == rhs.id
            && lhs.imageData == rhs.imageData
            && lhs.title == rhs.title
            && lhs.subtitle == rhs.subtitle
            && lhs.date == rhs.date
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    

}
