//
//  CellUpdate.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 11.05.2021.
//

import UIKit

protocol ConfiguringCell {
    func updateContent<T> (with viewModel: T) -> ()
}
