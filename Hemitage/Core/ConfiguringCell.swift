//
//  CellUpdate.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.05.2021.
//

import Foundation

protocol ConfiguringCell {
    func updateContent<T> (with data: T) -> ()
}
