//
//  TemplateSongView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 06.05.2021.
//

import UIKit

@IBDesignable
class TemplateSongView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nameSongLabel: UILabel!
    @IBOutlet weak var albumSongLabel: UILabel!
    @IBOutlet weak var imageSong: UIImageView!
    
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
        Bundle.main.loadNibNamed(String(describing: TemplateSongView.self), owner: self)
        updateUI()
    }
    
    private func updateUI() {
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        imageSong.layer.cornerRadius = 8
    }
    
    // MARK: - Actions
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        
        let nameImageForButton = sender.imageView?.image == UIImage(systemName: "pause") ? "play" : "pause"
        sender.setImage(UIImage(systemName: nameImageForButton), for: .normal)
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.isHidden = true
    }
    
    

}
