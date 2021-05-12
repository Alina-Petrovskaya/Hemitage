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
    @IBOutlet private weak var songNameLabel: UILabel!
    @IBOutlet private weak var singerLabel: UILabel!
    @IBOutlet private weak var imageSong: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    
    var viewModel: some TemplatesViewModelProtocol = ViewModelTemplateSong()
    
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
        configureContent()
        
        viewModel.getDataForContent()
    }
    
    private func configureUI() {
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        imageSong.layer.cornerRadius = 8
    }
    
    private func configureContent() {
        viewModel.dataModel = { [weak self] data in
            guard let model = data as? SongModel else { return }
            self?.songNameLabel.text = model.songName
            self?.singerLabel.text   = model.singer
                    
            if model.imageName != "", let image = UIImage(named: model.imageName) {
                self?.imageSong.image = image
            }
        }
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
