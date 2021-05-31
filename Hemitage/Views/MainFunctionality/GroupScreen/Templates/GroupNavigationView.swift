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
    @IBOutlet weak var image: UIImageView!
    
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
    }

    
    private func configureUI() {
        contentView.backgroundColor = #colorLiteral(red: 0.4156862745, green: 0.4196078431, blue: 0.6431372549, alpha: 1)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        bottomView.layer.cornerRadius = 40
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomView.layer.masksToBounds = true
    }
    
    
    func updateUI(_ backgroundColor: UIColor, image: UIImage, title: String, subtitle: String) {
        
    }
    
    
    func regulateElementsTransparency() {
        
        topTitle.isHidden = !topTitle.isHidden
        mediumTitle.isHidden = !mediumTitle.isHidden
        image.isHidden = !image.isHidden

    }
}
