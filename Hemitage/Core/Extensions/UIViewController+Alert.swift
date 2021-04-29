//
//  UIViewController+Alert.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 29.04.2021.
//

import UIKit

extension UIViewController {
    func showErrorAlert(with message: String) {
        let alert = UIAlertController(title: "Ooops", message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel)
        
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}

