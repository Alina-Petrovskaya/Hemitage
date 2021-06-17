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
    func handleInteraction(interactionType: SongTemplateTypeOfInteraction, completion: ((ViewModelTemplateSongProtocol) -> ())?)
    func isPremiumContenHidden() -> Bool
}

