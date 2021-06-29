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
    @IBOutlet private weak var headerView: TemplateProfileHeaderView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        let builder = MainScreenBuilder()
        dataSourceManager = builder.build(with: collectionView, with: viewModel)
        
        handlingCollectionViewDelegateEvents()
        handlingViewModelEvents()
        manageHeaderScreen()
        
        handleSongEvents()
    }
    
    
    private func handlingCollectionViewDelegateEvents() {
        
        viewModel.manageCollectionActions(with: dataSourceManager?.collectionViewDelegate) { [weak self] result in
            print("Section: \(result.section)")
            
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
        
        
        dataSourceManager?.headerCallback = { print("Present all news") }
    }
    
    
    private func manageHeaderScreen() {
        viewModel.getUserData { [weak self] headerViewModel in
            self?.headerView.configureContent(with: headerViewModel)
        }
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
        
        viewModel.songChanged = { [weak self] result in
            self?.songBottomView.isHidden = result.isHidden
            self?.songBottomView.updateSongData(with: result.data)
        }
    }
    
    private func handleSongEvents() {
        PlayerManager.shared.getNotificationWithCurrentSong()
        
        songBottomView.playCallBack = { [weak self] _ in
            self?.viewModel.changePlayerState(action: .play)
        }
        
        songBottomView.stopCallback = { [weak self] in
            self?.viewModel.changePlayerState(action: .stop)
        }
    }
}
