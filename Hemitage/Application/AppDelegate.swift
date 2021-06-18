//
//  AppDelegate.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 26.04.2021.
//

import UIKit
import Firebase
import FBSDKCoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navVC = UINavigationController(rootViewController: RootViewController())
        window?.rootViewController = navVC
        window?.backgroundColor    = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
    }
    
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if let incomingURL = userActivity.webpageURL {
            handleIncomingLink(incomingURL)
            
            return true
        }
        return false
    }
    
    
    
    func handleIncomingLink(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItrems = components.queryItems  else { return }
        
        // Handle items to reset password
        if queryItrems[0].name == "mode",  queryItrems[0].value == "resetPassword" {
            
            for item in queryItrems {
                if item.name == "oobCode", let safeCode = item.value {
                    PasswordObbCodeManager.shared.checkObbCode(with: safeCode)
                }
            }
        }
    }
    
    
}

