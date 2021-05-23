//
//  MainScreenCollectionViewCellModelViewProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 13.05.2021.
//

import Foundation


protocol MainScreenCollectionViewCellModelViewProtocol {
    
    func updateContent<T>(with viewModel: T) -> ()
    func getData<T>() -> T
}
