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
    var viewModel: GroupScreenViewModel?
    let navigationView = GroupNavigationView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateNavigationBarView()
        observeNavBarState()
        backButtonTaped()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
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
        
        
        if let dataforNavigationView: GroupNavigationViewModel  = viewModel?.getDataContent(for: .navigationBar) {
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
