//
//  PasscodeRecoveryViewModel.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 25.05.2021.
//

import Foundation

protocol PasscodeRecoveryViewModelProtocol {
    var keyBoardCallBack: (() -> ())? { get set }
}


class PasscodeRecoveryViewModel: PasscodeRecoveryViewModelProtocol {
    var keyBoardCallBack: (() -> ())?
    
}
