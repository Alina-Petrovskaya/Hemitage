//
//  GroupNavigationViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 31.05.2021.
//

import Foundation

class GroupNavigationViewModel: ViewModelConfigurator {
    
    private var title: String
    private var imageURL: URL?
    private var subtitle: String?
    
    init(title: String, imageURL: URL?, subtitle: String?) {
        self.title    = title
        self.imageURL = imageURL
        self.subtitle = subtitle
    }
    
    
    func getData() -> (title: String, imageURL: URL?, subtitle: String?) {
        return (title: title, imageURL: imageURL, subtitle: subtitle)
    }
    
    func setData(with data: (title: String, imageURL: URL?, subtitle: String?) ) {
        self.title    = data.title
        self.imageURL = data.imageURL
        self.subtitle = data.subtitle
    }
    
}
