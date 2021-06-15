//
//  GroupScreenViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 27.05.2021.
//

import UIKit

class GroupScreenViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var kvoNavBar: NSKeyValueObservation?
    var viewModel: GroupScreenViewModelProtocol?
    
    private var collectionViewDataSourse: GroupScreenDataSourceProtocol?
    private var tableViewDataSource: GroupScreenDataSourceProtocol?
    private var navigationView = GroupNavigationView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        
        guard let safeViewModel = viewModel as? GroupScreenViewModel else { return }
        
        collectionViewDataSourse = GroupScreenDirector().buildData(with: safeViewModel, builder: GroupScreenCollectionViewBuilder(), object: collectionView)
        tableViewDataSource = GroupScreenDirector().buildData(with: safeViewModel, builder: GroupScreenTableViewBuilder(), object: tableView)
        
        updateNavigationBarView()
        observeNavBarState()
        backButtonTaped()
        observeDataSourceDelegates()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        kvoNavBar?.invalidate()
    }
    
    
    private func observeNavBarState() {
        kvoNavBar = navigationController?.observeState() { [weak self] isLarge in
            self?.navigationView.regulateElementsTransparency(isLarge)
        }
    }
    
    
    func observeDataSourceDelegates() {
        var tableDelegate: GroupScreenTableDelegateProtocol? = tableViewDataSource?.getDelegateObject()
        var collectionDelegate: GroupScreenCollectionDelegateProtocol? = collectionViewDataSourse?.getDelegateObject()
        
        tableDelegate?.requestForMoreItems = { [weak self] in
            self?.viewModel?.querySongItems()
        }
        
        tableDelegate?.rowTapped = { [weak self] index in
            self?.viewModel?.playSong(at: index, category: .songList)
        }
        
        collectionDelegate?.rowTapped = { [weak self] index in
            self?.viewModel?.newSubcategoryTapped(with: index)
        }
    }
  
    
    private func updateNavigationBarView() {
        navigationController?.setupForGroupController()
        navigationController?.updateSubview(with: &navigationView)

        if let dataforNavigationView: GroupNavigationViewModel  = viewModel?.getDataContent(for: .navigationBar)?[0] {
            navigationView.updateUI(with: dataforNavigationView)
        }
    }
    
    // MARK: - Handle Actions
    private func backButtonTaped() {
        navigationView.backButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
}


extension GroupScreenViewController: GroupScreenViewModelDelegate {
    
    func reloadData(section: GroupScreenTypeOfContent) {
        let dataSourse: GroupScreenDataSourceProtocol? = (section == .subGroup) ? collectionViewDataSourse : tableViewDataSource
        if let viewModel = viewModel as? GroupScreenViewModel {
            dataSourse?.reloadData(with: viewModel)
            if section == .subGroup {
                collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .right)
            }
        }
    }
    
    
    func updateData<T: ViewModelConfigurator>(items: [T], section: GroupScreenTypeOfContent, typeOfChange: TypeOfChangeDocument, index: Int? = nil)  {
        
        let dataSourse: GroupScreenDataSourceProtocol? = (section == .subGroup) ? collectionViewDataSourse : tableViewDataSource
        
        switch typeOfChange {
        case .added:
            dataSourse?.insertItems(items: items)
            
        case .modified:
            if let safeIndex = index {
                dataSourse?.reloadItems(data: items[0], with: safeIndex)
            }
            
        case .removed:
            dataSourse?.deleteItems(items: items)
        }
    }
}
