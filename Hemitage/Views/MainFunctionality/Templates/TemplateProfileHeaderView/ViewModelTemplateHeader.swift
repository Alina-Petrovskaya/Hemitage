//
//  ViewModelTemplateHeader.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 12.05.2021.
//

import Foundation

class ViewModelTemplateHeader: ViewModelConfigurator {
   
    typealias DataType = (name: String, image: String, isNewNotificatoins: Bool)
    
    var name: String
    var image: String
    var isNewNotificatoins: Bool
    
    init(model: ProfileModel) {
        name = model.name
        image = model.imageName
        isNewNotificatoins = model.isNewNotificatoins
        
    }
    
    func getData() -> DataType {
        
        return (name: name, image: image, isNewNotificatoins: isNewNotificatoins)
        
    }
    
    func setData(with data: DataType) {
        name = data.name
        image = data.image
        isNewNotificatoins = data.isNewNotificatoins
        
    }
}
