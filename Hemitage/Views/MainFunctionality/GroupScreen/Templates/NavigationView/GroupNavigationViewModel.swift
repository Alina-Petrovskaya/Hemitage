//
//  GroupNavigationViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 31.05.2021.
//

import Foundation

class GroupNavigationViewModel: ViewModelConfigurator {
    
    typealias DataType = (title: String, imageURL: URL?, subtitle: String?, isDarkText: Bool)
    
    private var title: String
    private var imageURL: URL?
    private var subtitle: String?
    private var isDarkText: Bool
    
    
    init(with data: DataType) {
        self.title      = data.title
        self.imageURL   = data.imageURL
        self.subtitle   = data.subtitle
        self.isDarkText = data.isDarkText
    }
    
    
    func getData() -> (DataType) {
        return (title: title, imageURL: imageURL, subtitle: subtitle, isDarkText: isDarkText)
    }
    
    
    func getID() -> String {
        return title
    }
    
    
    func setData(with data: DataType ) {
        self.title      = data.title
        self.imageURL   = data.imageURL
        self.subtitle   = data.subtitle
        self.isDarkText = data.isDarkText
    }
    
}
