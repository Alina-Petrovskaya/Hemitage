//
//  MainScreenHeaderView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 07.05.2021.
//

import UIKit

@IBDesignable
class MainScreenHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryButton: UIButton!
    
    var callBack: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    @IBAction private func categoryButtonTapped(_ sender: UIButton) {
        callBack?()
    }
}
