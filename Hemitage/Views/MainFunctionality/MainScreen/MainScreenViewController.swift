//
//  MainScreenViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 05.05.2021.
//

import UIKit

class MainScreenViewController: UIViewController {

    var viewModel: MainScreenViewModelProtocol = MainScreenViewModel()
    
    private var dataSourceManager: MainScreenDataSourceManagerProtocol?
    
    @IBOutlet private weak var songBottomView: TemplateSongView!
    @IBOutlet private weak var headerView: TemplateHeaderView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        let builder = MainScreenBuilder()
        dataSourceManager = builder.build(with: collectionView, with: viewModel)
        
        
        handlingCollectionViewDelegateEvents()
        handlingViewModelEvents()
    }
    
    
    private func handlingCollectionViewDelegateEvents() {
        
        dataSourceManager?.collectionViewDelegate.callBack = { [weak self] indexPath in
            self?.viewModel.getItem(for: indexPath) { result in
                switch result.section {
                
                case .map:
                    break
                    
                case .categories:
                    guard let groupScreenVC = GroupScreenViewController.instantiate(),
                          let model = result.model as? CategoriesModel
                    else { return }
                    
                    groupScreenVC.viewModel = GroupScreenViewModel(with: model)
                    self?.navigationController?.pushViewController(groupScreenVC, animated: true)
                    
                case .blog:
                    print("Present article detail VC")
                }
            }
        }
        
        dataSourceManager?.headerCallback = { print("Present blog VC")}
    }
    
    
    
    private func handlingViewModelEvents() {
        viewModel.itemsDeleted = { [weak self] items in
            if let self = self {
                self.dataSourceManager?.deleteItems(items: items)
            }
        }
        
        
        viewModel.itemsInserted = { [weak self] data in
            if let self = self {
                self.dataSourceManager?.insertItems(items: data.items, at: data.section)
            }
        }
        
        
        viewModel.itemsReloaded = { [weak self] data in
            if let self = self {
                self.dataSourceManager?.reloadItems(data: data.newData, section: data.section, with: data.index)
            }
        }
    }
}
