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
    private let navigationView = GroupNavigationView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        
        collectionViewDataSourse = GroupScreenDirector().buildData(with: viewModel! as! GroupScreenViewModel, builder: GroupScreenCollectionViewBuilder(), object: collectionView)
        
       
        
        updateNavigationBarView()
        observeNavBarState()
        backButtonTaped()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        kvoNavBar?.invalidate()
    }
    
    
    private func observeNavBarState() {
        kvoNavBar = navigationController?.navigationBar.observe(\.bounds, options: [.new]) { [weak self] navigationBar, changes in
            guard let height = changes.newValue?.height else { return }
            
            self?.viewModel?.heightNavBarHandling(height: Double(height), completion: {
                self?.navigationView.regulateElementsTransparency()
            })
        }
    }
  
    
    private func updateNavigationBarView() {
        navigationController?.setupForGroupController()
        
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        navigationController?.navigationBar.addSubview(navigationView)
        
        if let navBar = navigationController?.navigationBar {
            NSLayoutConstraint.activate([
                navigationView.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: -1),
                navigationView.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: 1),
                navigationView.topAnchor.constraint(equalTo: navBar.topAnchor, constant: -50),
                navigationView.heightAnchor.constraint(equalTo: navBar.heightAnchor, constant: 100)
            ])
        }
        
        
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
    
    func itemsInserted<T: ViewModelConfigurator>(items: [T], section: GroupScreenTypeOfContent) {
        switch section {
        case .navigationBar:
            break
            
        case .subGroup:
            collectionViewDataSourse?.insertItems(items: items)
            
        case .songList:
            break
        }
        
    }
    
    func itemsReloaded<T: ViewModelConfigurator>(newData: T, section: GroupScreenTypeOfContent, index: Int) {
        
    }
    
    
    func itemsDeleted<T: ViewModelConfigurator>(items: [T], section: GroupScreenTypeOfContent) {
        
    }
    
    
}
