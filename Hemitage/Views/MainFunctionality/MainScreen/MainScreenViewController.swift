//
//  MainScreenViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 05.05.2021.
//

import UIKit

class MainScreenViewController: UIViewController {

    @IBOutlet private weak var songBottomView: TemplateSongView!
    @IBOutlet private weak var headerView: TemplateHeaderView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var viewModel: MainScreenModelViewProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        prepareViewModel()
    }
    
    
    private func prepareViewModel() {
        viewModel = MainScreenModelView(with: collectionView)
        
        viewModel?.userInteractionCallBack = { data in
            switch data {
            
            case .map(_):
                break
                
            case .category(_):
                print("Present group VC")
                
            case .blog(_):
                print("Present article detail VC")
            }
        }
        
        viewModel?.headerCallBack = { print("Present blog") }
    }
}
