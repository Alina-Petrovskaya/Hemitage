//
//  GroupScreenViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 27.05.2021.
//

import UIKit

class GroupScreenViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var observer: NSKeyValueObservation?
    let viewModel = GroupScreenViewModel()

    let navigationView: GroupNavigationView = {
        let view = GroupNavigationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        updateNavigationBarView()
        observeNavBarState()
        
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    private func observeNavBarState() {

        observer = navigationController?.navigationBar.observe(\.bounds, options: [.new]) { [weak self] navigationBar, changes in
            guard let height = changes.newValue?.height else { return }
            self?.viewModel.heightNavBarHandling(height: Double(height), completion: {
                self?.navigationView.regulateElementsTransparency()
            })
        }
    }
    
    private func updateNavigationBarView() {
        navigationController?.setupForGroupController(with: #colorLiteral(red: 0.4156862745, green: 0.4196078431, blue: 0.6431372549, alpha: 1))
        
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
        observer?.invalidate()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "test"
        
        return cell
    }
}
