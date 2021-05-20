//
//  KeyboardManager.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 28.04.2021.
//

import UIKit

class KeyboardManager {
    
    var keyboardStateChanged: ((CGFloat) -> ())?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        else { return }
        
        let keyBoardHeight = keyboardFrame.size.height
        keyboardStateChanged?(keyBoardHeight + 40.0)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        keyboardStateChanged?(0)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
