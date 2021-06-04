//
//  UINavigationController .swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 31.05.2021.
//

import UIKit

extension UINavigationController {
    
    func setupForGroupController() {
        
        self.navigationBar.isHidden = false
        self.navigationBar.prefersLargeTitles = true
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
}
