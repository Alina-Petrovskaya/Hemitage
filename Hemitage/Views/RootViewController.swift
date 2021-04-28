//
//  RootViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 26.04.2021.
//

import UIKit

class RootViewController: UIViewController {
    
    enum NextViewController {
        case loginVC
        case signInVC
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        goToWelcomeController()
    }
    
    private func goToWelcomeController() { // Here we'll deside what controller we'll show
        guard let vc = WelcomeViewController.instantiate()
        else {
            print("Can't create path to Welcome VC")
            return
        }
        
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
    }
    
    
    func goToNextController(_ controller: NextViewController) -> UIViewController? {
        switch controller {
        case .loginVC:
            guard let vc = LoginViewController.instantiate() else { return nil }
            return vc
            
        case .signInVC:
            guard let vc = SignInViewController.instantiate() else { return nil }
            return vc
        }
    }
}
