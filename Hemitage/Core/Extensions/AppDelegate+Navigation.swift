//
//  AppDelegate+Navigation.swift
//  Hemitage
//
//  Created by Alina Petrovskaya on 28.04.2021.
//

import UIKit

extension AppDelegate {
   static var shared: AppDelegate {
      return UIApplication.shared.delegate as! AppDelegate
   }
    
var rootViewController: RootViewController {
      return window!.rootViewController as! RootViewController
   }
}
