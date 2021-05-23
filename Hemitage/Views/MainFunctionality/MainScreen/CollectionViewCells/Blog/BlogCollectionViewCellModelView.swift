//
//  BlogCollectionViewCellModelView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 13.05.2021.
//

import Foundation

class BlogCollectionViewCellModelView: MainScreenCollectionViewCellModelViewProtocol, Hashable {
    
    private let id: String
    private var title: String
    private var subtitle: String?
    private var date: String
    private var imageData: Data?

    init(id: String, title: String, subtitle: String?, date: Date, imageData: Data?) {
        self.id         = id
        self.title      = title
        self.subtitle   = subtitle
        self.date       = date.stringRepresentation()
        self .imageData = imageData
    }
    
    
    func updateContent<T>(with data: T) {
        guard  let safeData = data as? (title: String, subtitle: String?, date: String, imageData: Data?)
        else { return }
        
        self.title      = safeData.title
        self.subtitle   = safeData.subtitle
        self.date       = safeData.date
        self .imageData = safeData.imageData
    }
    
    
    func getData<T>() -> T {
        guard let data: T = (title: title, subtitle: subtitle, date: date, imageData: imageData) as? T else {
            fatalError("Can't return data for Blog row")
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
