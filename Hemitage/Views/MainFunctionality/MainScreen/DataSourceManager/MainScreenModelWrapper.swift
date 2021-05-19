//
//  MainScreenModelWrapper.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.05.2021.
//

import Foundation

enum MainScreenModelWrapper: Hashable {
    case map(MapModel)
    case category(CategoriesModel)
    case blog(Article)
}
