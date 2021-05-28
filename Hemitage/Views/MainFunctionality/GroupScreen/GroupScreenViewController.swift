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

    let navigationView: GroupNavigationView = {
        let view = GroupNavigationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar(with: #colorLiteral(red: 0.4173461795, green: 0.4213980436, blue: 0.6433352828, alpha: 1))
        updateNavigationBarView()
        
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    private func setupNavigationBar(with color: UIColor) {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "Group 257"), for: .any, barMetrics: .default)
        navigationController?.navigationBar.isTranslucent = true

        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = 2

        navigationController?.navigationBar.largeTitleTextAttributes = [
            .baselineOffset: 30.0,
            .paragraphStyle: style
        ]

        
        observer = navigationController?.navigationBar.observe(\.bounds, options: [.new]) { [weak self] navigationBar, changes in
            
            if let height = changes.newValue?.height {
                if height > 44.0 {
                    self?.navigationView.mediumTitle.isHidden = false
                    self?.navigationView.topTitle.isHidden = true
                } else {
                    self?.navigationView.mediumTitle.isHidden = true
                    self?.navigationView.topTitle.isHidden = false
                    
                }
            }
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
