//
//  PaymentCellViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 22.06.2021.
//

import Foundation



class PaymentCellViewModel: DiffableCellViewModel, ViewModelConfigurator {

    override var type: TableCellType { .payment }
    
    var id: String    = ""
    var title: String = "jshkjsdhfkjhsd sdfgh"
    var price: String = "3.99 / month"
    var image: URL?   = nil
    
    
    func getData() -> (title: String, price: String, image: URL?) {
        return (title, price, image)
    }
    
    
    func setData(with data: (title: String, price: String, image: URL?)) {
        title = data.title
        price = data.price
        image = data.image
    }
    
    func getID() -> String {
        return id
    }
    
}
