//
//  RootViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 26.04.2021.
//

import UIKit

class RootViewController: UITabBarController, UITabBarControllerDelegate {
    
    private let userManager: FireStoreUserManagerProtocol = FireStoreUserManager()
    
    private func prepareUI() {
        navigationController?.navigationBar.isHidden = true
        
        tabBar.barTintColor = .white
        tabBar.tintColor    = #colorLiteral(red: 0.902816236, green: 0.729167521, blue: 0.6777408719, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        prepareUI()
        passwordManagerObserve()
        
        if userManager.isUserOnline() {
            presentContent()
            
        } else {
            presentAuthController()
        }
    }
    
    private func passwordManagerObserve() {
        PasswordObbCodeManager.shared.callback = { [weak self] result in

            switch result {
            case .success((let obbcode, let email)):
                guard let newPasscodeVC = NewPasscodeViewController.instantiate() else { return }
                
                newPasscodeVC.viewModel = NewPasscodeViewModel(email: email, obbCode: obbcode)
                

                self?.navigationController?.pushViewController(newPasscodeVC, animated: true)
                

            case .failure(let error):
                self?.showErrorAlert(with: error.localizedDescription)
            }
        }
    }
    
    
    private func presentContent() {

        guard let mainVC = MainScreenViewController.instantiate()
              else { return }
        
        mainVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "home"), selectedImage: UIImage(named: "home-fill"))
        
        let controllers = [mainVC]
        self.viewControllers = controllers
    }
    
    
    private func presentAuthController() {
        guard let vc = WelcomeViewController.instantiate() else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
