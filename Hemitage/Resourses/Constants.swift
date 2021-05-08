//
//  Constants.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 06.05.2021.
//

import UIKit

struct Constants {
   // static let shared = Constants()
    
    //    Color Names
    struct Colors {
        static let darkText = "DarkText #18191A"
        static let grayText = "GrayText #9B9B9B"
        static let underline = "Border #EEEEEE"
        static let mainColor = "Main color #DFAB9D"
    }
    
    
    // Fonts
    enum FontBook: String  {
        case montserratSemiBold = "Montserrat SemiBold"
        case interSemiBold      = "Inter Regular"
        case interRegular       = "Inter Bold"
        case interBold          = "Inter SemiBold"
        
        
        func of (size: CGFloat) -> UIFont? {
            return UIFont(name: self.rawValue, size: size)
        }
    }
}
