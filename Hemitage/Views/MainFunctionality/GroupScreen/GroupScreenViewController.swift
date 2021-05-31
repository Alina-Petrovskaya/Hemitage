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
    let navigationView: GroupNavigationView = {
        let view = GroupNavigationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        updateNavigationBarView()
        observeNavBarState()
    }
    
    
    private func observeNavBarState() {
        kvoNavBar = navigationController?.navigationBar.observe(\.bounds, options: [.new]) { [weak self] navigationBar, changes in
            guard let height = changes.newValue?.height else { return }
            
            self?.viewModel?.heightNavBarHandling(height: Double(height), completion: {
                self?.navigationView.regulateElementsTransparency()
            })
        }
    }
    
    
    private func prepareUI() {
       UIColor.getColor(from: nil) { [weak self] color in
            self?.contentView.backgroundColor = color
            self?.navigationController?.setupForGroupController(with: color)
        }
    }
    
    private func updateNavigationBarView() {
        navigationController?.navigationBar.addSubview(navigationView)
        
        NSLayoutConstraint.activate([
            navigationView.leadingAnchor.constraint(equalTo: navigationController!.navigationBar.leadingAnchor, constant: -1),
            navigationView.trailingAnchor.constraint(equalTo: navigationController!.navigationBar.trailingAnchor, constant: 1),
            navigationView.topAnchor.constraint(equalTo: navigationController!.navigationBar.topAnchor, constant: -20),
            navigationView.heightAnchor.constraint(equalTo: navigationController!.navigationBar.heightAnchor, constant: 80)
        ])
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        kvoNavBar?.invalidate()
    }
    
    
}
