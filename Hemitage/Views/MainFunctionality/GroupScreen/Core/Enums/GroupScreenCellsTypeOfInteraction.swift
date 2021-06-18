//
//  GroupScreenCellsTypeOfInteraction.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 16.06.2021.
//

import Foundation

enum GroupScreenCellsTypeOfInteraction {
    
    case save(Int, GroupScreenTypeOfContent)
    case play(Int, GroupScreenTypeOfContent)
    case showDetail(Int, GroupScreenTypeOfContent)
    case reload(Int, GroupScreenTypeOfContent)
    case requestForMoreItems(GroupScreenTypeOfContent)
    
}
