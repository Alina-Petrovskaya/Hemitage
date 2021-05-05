//
//  TemplateHeaderView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 05.05.2021.
//

import UIKit

@IBDesignable
class TemplateHeaderView: UIView {
    
    var nibName: String?

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var notificationIndicator: UIView!
    @IBOutlet weak var profilePhoto: UIImageView!
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        
        nibName = String(describing: TemplateHeaderView.self)
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        nibName = String(describing: TemplateHeaderView.self)
        super.init(coder: coder)
        
        commonInit()
    }
    
    
    private func commonInit() {
        guard let nibName = nibName else { return }
        Bundle.main.loadNibNamed(nibName, owner: self)
        
        updateUI()
    }
    
    
    private func updateUI() {
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        profilePhoto.layer.cornerRadius = profilePhoto.frame.size.height / 2
        notificationIndicator.layer.cornerRadius = notificationIndicator.frame.size.height / 2
    }
    
    override func draw(_ rect: CGRect) {
        let linePath = UIBezierPath()
        linePath.lineWidth = 2

        linePath.move(to: CGPoint(x: 0, y: bounds.height))
        linePath.addLine(to: CGPoint(x: bounds.width, y: bounds.height))

        UIColor.init(cgColor: #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)).setStroke()
        linePath.stroke()
    }

    @IBAction func notificationsButtonTapped(_ sender: UIButton) {
        notificationIndicator.isHidden = !notificationIndicator.isHidden
    }
}
