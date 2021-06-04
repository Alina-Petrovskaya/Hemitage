//
//  GroupScreenDirector.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 02.06.2021.
//

import UIKit

class GroupScreenDirector {
    
    func buildData<T: GroupScreenViewModelProtocol>(with viewModel: T, builder: GroupScreenBuilder, object: UIScrollView) -> GroupScreenDataSourceProtocol? {
        
        builder.registerNibs(for: object)
        builder.setLayout(for: object)
        
        return builder.setupDataSource(for: object, with: viewModel)
    }
}
