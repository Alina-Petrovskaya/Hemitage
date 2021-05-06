//
//  TemplateHeaderView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 05.05.2021.
//

import UIKit

@IBDesignable
class TemplateHeaderView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var notificationIndicator: UIView!
    @IBOutlet weak var profilePhoto: UIImageView!
    
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
        Bundle.main.loadNibNamed(String(describing: TemplateHeaderView.self), owner: self)
        updateUI()
    }
    
    
    private func updateUI() {
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        profilePhoto.layer.cornerRadius = profilePhoto.frame.size.height / 2
        notificationIndicator.layer.cornerRadius = notificationIndicator.frame.size.height / 2
    }

    @IBAction func notificationsButtonTapped(_ sender: UIButton) {
        notificationIndicator.isHidden = !notificationIndicator.isHidden
    }
}
