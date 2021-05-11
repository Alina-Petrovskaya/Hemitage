//
//  TemplateSongView.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 06.05.2021.
//

import UIKit

@IBDesignable
class TemplateSongView: UIView {

    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var singerLabel: UILabel!
    @IBOutlet private weak var nameSongLabel: UILabel!
    @IBOutlet private weak var imageSong: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    
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
        configureUI()
    }
    
    private func configureUI() {
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        imageSong.layer.cornerRadius = 8
    }
    
    func updateUI(with songInformation: SongModel, closebuttonIsHidden: Bool = true) {
        closeButton.isHidden = closebuttonIsHidden
        singerLabel.text     = songInformation.singer
        nameSongLabel.text   = songInformation.songName
        imageSong.image      = UIImage(named: songInformation.imageName)
    }
    
    // MARK: - Actions
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        let nameImageForButton = sender.currentImage == UIImage(systemName: "pause") ? "play" : "pause"
        sender.setImage(UIImage(systemName: nameImageForButton), for: .normal)
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        //self.isHidden = true
    }
}
