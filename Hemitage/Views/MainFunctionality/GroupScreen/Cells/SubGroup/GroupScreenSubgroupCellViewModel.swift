//
//  GroupScreenSubgroupCellViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 02.06.2021.
//

import Foundation

class GroupScreenSubgroupCellViewModel: ViewModelConfigurator {
    func getData() -> DataType {
        
        return (id: "", title: "")
    }
    
    func setData(with data: DataType) {
        
    }
    
    typealias DataType = (id: String, title: String)
    
    
}
