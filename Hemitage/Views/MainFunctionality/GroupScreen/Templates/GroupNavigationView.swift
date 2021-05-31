//
//  GroupNavigationView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 28.05.2021.
//

import UIKit
import SDWebImage

@IBDesignable
class GroupNavigationView: UIView {
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var bottomView: UIView!
    @IBOutlet private weak var topTitle: UILabel!
    @IBOutlet private weak var mediumTitle: UILabel!
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var subtitle: UILabel!
    

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
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        bottomView.layer.cornerRadius = 40
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomView.layer.masksToBounds = true
    }
    
    
    func updateUI<T: ViewModelConfigurator>(with model: T) {
        let model = model as? GroupNavigationViewModel
        let data = model?.getData()
        
        mediumTitle.text = data?.title
        topTitle.text = data?.title
        subtitle.text = data?.subtitle
        
        image.sd_setImage(with: data?.imageURL) { [weak self] image, _, _, _ in
            if let image = image {
                self?.contentView.backgroundColor = UIColor(patternImage: image)
            }
        }
    }
    
    
    @IBAction func backbuttonTapped(_ sender: UIButton) {
        
    }
    
    
    func regulateElementsTransparency() {
        
        topTitle.isHidden = !topTitle.isHidden
        mediumTitle.isHidden = !mediumTitle.isHidden
        image.isHidden = !image.isHidden

    }
}
