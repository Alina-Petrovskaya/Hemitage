//
//  HeaderView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 05.05.2021.
//

import UIKit

@IBDesignable
class HeaderView: UIView {
    
    @IBOutlet  var welcomeLabel: UILabel!
    @IBOutlet  var notificationIndicator: UIView!
    @IBOutlet  var profilePhoto: UIImageView!
    
    var contentView: UIView?
    @IBInspectable var nibName: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
        
        profilePhoto.layer.cornerRadius = profilePhoto.frame.size.height / 2
        notificationIndicator.layer.cornerRadius = notificationIndicator.frame.size.height / 2
    }
    
    override func prepareForInterfaceBuilder() {
        
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView?.prepareForInterfaceBuilder()
    }
    
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(view)
        contentView = view
        
    }
    
    
    func loadViewFromNib() -> UIView? {
        guard let nibName = nibName else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate( withOwner: self, options: nil).first as? UIView
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
