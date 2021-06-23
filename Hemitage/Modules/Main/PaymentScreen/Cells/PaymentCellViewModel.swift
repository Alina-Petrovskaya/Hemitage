//
//  PaymentCellViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 22.06.2021.
//

import Foundation



class PaymentCellViewModel: DiffableCellViewModel, ViewModelConfigurator {
    
    override var type: TableCellType { .payment }
    
    let id: String
    var title: String
    var price: String
    var image: String
    var description: String
    
    
    init(with model: PaymentModel) {
        id          = model.id ?? "nil"
        title       = model.title
        price       = ("\(model.price) / month")
        image       = model.image
        description = model.description
    }
    
    
    func getData() -> (title: String, price: String, image: String, description: String) {
        return (title, price, image, description)
    }
    
    
    func setData(with data: (title: String, price: String, image: String, description: String)) {
        title       = data.title
        price       = data.price
        image       = data.image
        description = data.description
        
    }
    
    func getID() -> String {
        return id
    }
    
}
