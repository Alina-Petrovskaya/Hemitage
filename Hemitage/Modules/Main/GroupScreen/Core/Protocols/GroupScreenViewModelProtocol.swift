//
//  GroupScreenViewModelProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 07.06.2021.
//

import Foundation

protocol GroupScreenViewModelProtocol {
    
    var delegate: GroupScreenViewModelDelegate? { get set }
    
    func getDataContent<T: ViewModelConfigurator>(for contentType: GroupScreenTypeOfContent) -> [T]?
    
    /**
     Handle interactions from songs and subgroups rows
     */
    
    func handleInteraction(interactionType: GroupScreenCellsTypeOfInteraction,
                           completion: (((viewModel: ViewModelTemplateSongProtocol?, isNeedToByeMore: Bool)) -> ())?)
    
    func isPremiumContenHidden() -> Bool
}

