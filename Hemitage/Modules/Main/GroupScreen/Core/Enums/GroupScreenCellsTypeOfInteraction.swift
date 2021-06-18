//
//  GroupScreenCellsTypeOfInteraction.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 16.06.2021.
//

import Foundation

enum GroupScreenCellsTypeOfInteraction {
    
    case save(_ index: Int, GroupScreenTypeOfContent, _ isCanPlay: Bool)
    case play(_ index: Int, GroupScreenTypeOfContent, _ isCanPlay: Bool)
    case showDetail(_ index: Int, GroupScreenTypeOfContent)
    case reload(_ index: Int, GroupScreenTypeOfContent)
    case requestForMoreItems(GroupScreenTypeOfContent)
    
}
