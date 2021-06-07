//
//  MainScreenCollectionViewCellModelViewProtocol.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 13.05.2021.
//

import Foundation


protocol MainScreenCollectionViewCellModelViewProtocol {
    
    func updateContent<T: MainScreenCollectionViewCellModelViewProtocol>(with data: T)
    func getData<T>() -> T
}
