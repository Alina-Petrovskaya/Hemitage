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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(String(describing: MainScreenHeaderView.self), owner: self)
        backgroundColor = .red
        
        categoryName.backgroundColor = .yellow
    }
    
    
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
    }
}
