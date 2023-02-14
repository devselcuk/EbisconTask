//
//  AppDelegate.swift
//  EbisconTask
//
//  Created by SELCUK YILDIZ on 07.02.23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
     
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = NavigationViewController(rootViewController: DiscoveryViewController())
        window?.makeKeyAndVisible()
  
        
        return true
    }


}

