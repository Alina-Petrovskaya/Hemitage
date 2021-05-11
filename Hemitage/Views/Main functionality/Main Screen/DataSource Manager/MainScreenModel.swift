//
//  MainScreenModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.05.2021.
//

import Foundation

enum MainScreenModel: Hashable {
    case map(MapModel)
    case category(CategoriesModel)
    case blog(BlogModel)
}
