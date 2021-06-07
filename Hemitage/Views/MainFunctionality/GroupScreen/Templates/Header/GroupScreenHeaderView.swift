//
//  GroupScreenHeaderView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 07.06.2021.
//

import UIKit

@IBDesignable
class GroupScreenHeaderView: UIView {

    @IBOutlet var contentView: UIView!
    
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    private func commonInit() {
        Bundle.main.loadNibNamed(String(describing: GroupScreenHeaderView.self), owner: self)
        configureUI()
    }
    
    private func configureUI() {
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    

}
