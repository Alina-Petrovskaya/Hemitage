//
//  MainScreenViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 05.05.2021.
//

import UIKit

class MainScreenViewController: UIViewController {

    let viewModel: MainScreenViewModelProtocol = MainScreenViewModel()
    let builder = MainScreenBuilder()
    private var dataSourceManager: MainScreenDataSourceManagerProtocol?
    
    @IBOutlet private weak var songBottomView: TemplateSongView!
    @IBOutlet private weak var headerView: TemplateHeaderView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
    
        dataSourceManager = builder.build(with: collectionView, with: viewModel)
        
        builder.collectionViewDelegate.callBack = { [weak self] indexPath in
            guard let item = self?.viewModel.getItem(for: indexPath) else { return }
            
            switch item {
            case .map(_):
                break
                
            case .category(_):
                print("Present group VC")
                
            case .blog(_):
                print("Present article detail VC")
            }
        }
        
        
        dataSourceManager?.headerCallback = { print("Present blog VC")}
        
    }
}
