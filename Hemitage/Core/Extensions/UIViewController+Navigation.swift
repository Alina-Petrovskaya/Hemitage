//
//  UIViewController+Navigation.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 27.04.2021.
//

import UIKit

extension UIViewController {
    static func instantiate() -> Self? {
        let vcName = String(describing: self)
        let stroryBoard = UIStoryboard(name: vcName, bundle: .main)
        let vc = stroryBoard.instantiateViewController(withIdentifier: vcName)
        
        return vc as? Self
    }
}
