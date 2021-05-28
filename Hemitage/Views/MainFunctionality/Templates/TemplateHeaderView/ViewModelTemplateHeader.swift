//
//  ViewModelTemplateHeader.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 12.05.2021.
//

import Foundation

class ViewModelTemplateHeader: TemplatesViewModelProtocol {
    var dataModel: ((ProfileModel) -> ())?
    
    func getDataForContent() {
        //Get data from resource
        
        let model = ProfileModel(imageName: "Sleep", name: "Hi, Pussy", isNewNotificatoins: true)
            dataModel?(model)
    }
}
