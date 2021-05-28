//
//  GroupNavigationView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 28.05.2021.
//

import UIKit

@IBDesignable
class GroupNavigationView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var mediumTitle: UILabel!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    

    private func commonInit() {
        Bundle.main.loadNibNamed(String(describing: GroupNavigationView.self), owner: self)
        configureUI()
//        configureContent()
        
//        viewModel.getDataForContent()
    }

    
    private func configureUI() {
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        bottomView.layer.cornerRadius = 40
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomView.layer.masksToBounds = true
    }
}
