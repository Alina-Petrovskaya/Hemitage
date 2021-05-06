//
//  MainScreenViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 05.05.2021.
//

import UIKit

class MainScreenViewController: UIViewController {

    
    @IBOutlet weak var songBottomView: TemplateSongView!
    @IBOutlet weak var headerView: TemplateHeaderView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        
        collectionView.register(UINib(nibName: "MapCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "MapCollectionViewCell")
    }
}
