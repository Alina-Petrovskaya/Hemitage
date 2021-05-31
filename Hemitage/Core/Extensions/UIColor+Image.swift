//
//  UIColor+Image.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 30.05.2021.
//

import UIKit
import SDWebImage

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
    
    class func getColor(from imageURL: URL?, completion: @escaping (UIColor) -> ()) {
        let imageView = UIImageView()
        
        imageView.sd_setImage(with: imageURL) { image, _, _, _ in
            guard let image = image else { return }
            
            completion(UIColor(patternImage: image))
        }
    }
    
}
