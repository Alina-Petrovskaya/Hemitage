//
//  KeyboardStateObserver.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 30.04.2021.
//

import UIKit

@objc protocol KeyboardStateObserver {
    
    @objc dynamic var kvoKeyboardHeight: NSKeyValueObservation? { get set }
    
    var keyboardHeight: CGFloat { get set }
}

extension KeyboardStateObserver where Self: UIViewController {
    
    func observeKeyBoard<T: NSObject & KeyboardManagerPorotocol>(viewModel: T?) {
        
        kvoKeyboardHeight = viewModel?.observe(\.keyboardHeight, options: .new, changeHandler: { [weak self] _, heightInformation in
            guard let height = heightInformation.newValue else { return }
            self?.keyboardHeight = CGFloat(height)
        })
    }
}
