//
//  Builder.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 02.06.2021.
//

import UIKit

protocol GroupScreenBuilder {
    
    func setLayout(for object: UIScrollView)
    func registerNibs(for object: UIScrollView)
    func setupDataSource<T: GroupScreenViewModelProtocol>(for object: UIScrollView, with viewModel: T)
    
}
