//
//  AppDelegate.swift
//  myHouse
//
//  Created by Valera Petin on 25.01.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit
import Firebase
import SWRevealViewController
import FBSDKCoreKit
import FBSDKLoginKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var actIdc = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var conteiner: UIView!
    
    
    class func instance() -> AppDelegate {
        
        return UIApplication.shared.delegate as! AppDelegate
    }

    //Индикатор загрузки
    func showActivityIndicator() {
        
        if let window = window {
            conteiner = UIView()
            conteiner.frame = window.frame
            conteiner.center = window.center
            conteiner.backgroundColor = UIColor(white: 0, alpha: 0.8)
            
            actIdc.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            actIdc.hidesWhenStopped = true
            actIdc.center = CGPoint(x: conteiner.frame.size.width / 2, y: conteiner.frame.size.height / 2)
            
            conteiner.addSubview(actIdc)
            window.addSubview(conteiner)
            
            actIdc.startAnimating()
        }
    }
    
    //Скрытие индикатора загрузки
    func dismissActivityIndicators() {
    
        if let _ = window {
            conteiner.removeFromSuperview()
        }
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FIRApp.configure()
        logUser()
        
        //Белый статус бар
        UIApplication.shared.statusBarStyle = .lightContent
        
        //Заголовок
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 20)!]
        
        
      //  FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
        return true
    }
    
  /*  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return handled
    } */
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    func logUser(){
    
        if FIRAuth.auth()!.currentUser != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let home = storyboard.instantiateViewController(withIdentifier: "Home")
            self.window?.rootViewController = home
        }
    }
    
}
