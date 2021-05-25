//
//  RootViewController.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 26.04.2021.
//

import UIKit

class RootViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = .white
        tabBar.tintColor = #colorLiteral(red: 0.902816236, green: 0.729167521, blue: 0.6777408719, alpha: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
         presentAuthController()
//        presentContent()
    }
    
    private func presentContent() {
        guard let mainVC = MainScreenViewController.instantiate() else { return }
        
        mainVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "home"), selectedImage: UIImage(named: "home-fill"))
        
        let controllers = [mainVC]
        self.viewControllers = controllers
    }
    
    private func presentAuthController() {
//        guard let vc = PasscodeRecoveryViewController.instantiate()
        guard let vc = WelcomeViewController.instantiate()
//        guard let vc = LoginViewController.instantiate()
        else {
            print("Can't create path to Welcome VC")
            return
        }
        
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true;
    }
}
