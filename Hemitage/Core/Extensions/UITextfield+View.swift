//
//  UITextfield+View.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 27.04.2021.
//

import UIKit

extension UITextField {
    
    @IBInspectable var leftImage: UIImage {
        get {
            let UIImage = self.leftView?.subviews[0] as? UIImageView
            return UIImage?.image ?? #imageLiteral(resourceName: "FB icon")
        }
        
        set(image) {
            setLeftView(with: image)
        }
    }
    
    
    @IBInspectable var rightImage: UIImage {
        get {
            let UIImage = self.leftView?.subviews[0] as? UIImageView
            return UIImage?.image ?? #imageLiteral(resourceName: "FB icon")
        }
        
        set(image) {
            setRightButtonImage(with: image)
        }
    }
    
    
    private func setLeftView(with image: UIImage) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24))
        
        let imageView         = UIImageView(frame: CGRect(x: 16, y: 0, width: 24, height: 24))
        imageView.image       = image
        imageView.tintColor   = #colorLiteral(red: 0.6712639928, green: 0.6712799668, blue: 0.6712713838, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(imageView)
        
        self.leftView     = view
        self.leftViewMode = .always
    }
    
   private func setRightButtonImage(with image: UIImage) {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24))
        
        let button       = UIButton(type: .custom)
        button.frame     = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.tintColor = #colorLiteral(red: 0.6712639928, green: 0.6712799668, blue: 0.6712713838, alpha: 1)
    
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(self.changeVisibilityOfPassword), for: .touchUpInside)
        
        view.addSubview(button)
        
        
        self.rightView     = view
        self.rightViewMode = .always
    }
    
    
    @objc private func changeVisibilityOfPassword(sender: UIButton) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        if let buttonRightImage: UIImage = self.isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye") {
            rightImage = buttonRightImage
        }
        
        
    }
    
}


