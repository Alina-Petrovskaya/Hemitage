//
//  GroupScreenSubgroupCellViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 02.06.2021.
//

import Foundation

class GroupScreenSubgroupCellViewModel: ViewModelConfigurator, Hashable {
    
    typealias DataType = (id: String, title: String)
    
    private let id: String
    private var title: String
    
    
    init(with data: (id: String, title: String)) {
        self.id    = data.id
        self.title = data.title
    }
    
    
    func getData() -> DataType {
        return (id: id, title: title)
    }
    
    
    func setData(with data: DataType) {
        self.title = data.title
    }
    
    
    static func == (lhs: GroupScreenSubgroupCellViewModel, rhs: GroupScreenSubgroupCellViewModel) -> Bool {
        return lhs.id == rhs.id
            && lhs.title == rhs.title
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
}
