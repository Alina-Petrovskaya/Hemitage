//
//  UINavigationController .swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 31.05.2021.
//

import UIKit

extension UINavigationController {
    
    func setupForGroupController(with color: UIColor) {
        self.navigationBar.isHidden = false
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.setBackgroundImage(#colorLiteral(red: 0.4156862745, green: 0.4196078431, blue: 0.6431372549, alpha: 1).image(), for: .default)
        self.navigationBar.isTranslucent = true
        self.navigationItem.largeTitleDisplayMode = .automatic

        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = 2

        self.navigationBar.largeTitleTextAttributes = [
            .baselineOffset: 30.0,
            .paragraphStyle: style
        ]
    }
}
