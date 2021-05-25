//
//  PasscodeRecoveryViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 25.05.2021.
//

import Foundation

protocol PasscodeRecoveryViewModelProtocol {
   
}


class PasscodeRecoveryViewModel: NSObject, PasscodeRecoveryViewModelProtocol, KeyboardManagerPorotocol {
    
    @objc dynamic private(set)var keyboardHeight: Float = 0
    private let keyBoardManager = KeyboardManager()
    
    
    override init() {
        super.init()
        
        keyBoardManager.keyboardStateChanged = { [weak self] height in
            self?.keyboardHeight = Float(height)
        }
    }
    
}
