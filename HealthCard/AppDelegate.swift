//
//  AppDelegate.swift
//  HealthCard
//
//  Created by Viral on 30/03/22.
//

import UIKit
import GoogleMaps
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        GMSServices.provideAPIKey("AIzaSyCOkXvGWFAfSccRS-azPprnqKEn9vf2LLI")
        let islogin = UserDefaults.standard.bool(forKey: "isLogin")
        if islogin {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let homeVC = CustomTabBarViewController.instantiate()
            let navigationController = UINavigationController(rootViewController: homeVC)
            appDelegate.window!.rootViewController = navigationController
        } else {
            let mainStoryBoard = UIStoryboard(name: "Login", bundle: nil)
            let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "SingInVC") as! SingInVC
            let navigationController = UINavigationController(rootViewController: redViewController)
            
        }
        return true
    }

}

