//
//  UINavigationController .swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 31.05.2021.
//

import UIKit

extension UINavigationController {
    
    func setupForGroupController() {
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.isHidden = false
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.interactivePopGestureRecognizer?.isEnabled = false

        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = 2

        self.navigationBar.largeTitleTextAttributes = [
            .baselineOffset: 30.0,
            .paragraphStyle: style,
            .backgroundColor: UIColor(white: 1, alpha: 1)
        ]
    }
    
    func updateSubview(with view: inout GroupNavigationView) {
        navigationBar.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: -1),
            view.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: 1),
            view.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: -50),
            view.heightAnchor.constraint(equalTo: navigationBar.heightAnchor, constant: 100)
        ])
    }
}
