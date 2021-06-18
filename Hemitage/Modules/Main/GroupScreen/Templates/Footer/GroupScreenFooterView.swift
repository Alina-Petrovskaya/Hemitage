//
//  GroupScreenFooterView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 08.06.2021.
//

import UIKit

@IBDesignable
class GroupScreenFooterView: UIView {

    @IBOutlet private var parrentView: UIView!
    
    // MARK: - Life cycle'
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(String(describing: GroupScreenFooterView.self), owner: self)
        configureUI()
    }
    
    private func configureUI() {
        addSubview(parrentView)
        parrentView.frame = self.bounds
    }


}
