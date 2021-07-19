//
//  ViewModelTemplateHeader.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 12.05.2021.
//

import Foundation

class ViewModelTemplateHeader: ViewModelConfigurator {
   
    typealias DataType = (name: String, image: URL?, isNewNotificatoins: Bool)
    
    var name: String
    var image: URL?
    var isNewNotificatoins: Bool
    
    init(model: ProfileModel) {
        name = model.name
        image = model.image
        isNewNotificatoins = true
        
    }
    
    func getID() -> String {
        return name
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
