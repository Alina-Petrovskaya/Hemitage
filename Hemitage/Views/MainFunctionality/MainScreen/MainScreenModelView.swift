//
//  MainScreenModelView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 12.05.2021.
//

import Foundation

protocol MainScreenModelViewProtocol {

    var userInteractionCallBack: ((MainScreenModelWrapper) -> ())? { get set }
    var collectionViewDelegate: MainScreenCollectionViewDelegate { get }

}

final class MainScreenModelView: MainScreenModelViewProtocol {
    var userInteractionCallBack: ((MainScreenModelWrapper) -> ())?
    let collectionViewDelegate = MainScreenCollectionViewDelegate()
    
    
    init() {
        collectionViewDelegate.callBack = { [weak self] data in
            self?.userInteractionCallBack?(data)
        }
    }
}
