//
//  AppDelegate.swift
//  SwiftApp
//
//  Created by Mjwon on 2017/9/13.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let b = UserDefaults.standard.bool(forKey: "")
        
        if b == true {
            let vc = LoginViewController();
            let nav = UINavigationController(rootViewController:vc);
            self.window!.rootViewController = nav;
            
        }else{
            self.window!.rootViewController = self.homeTabbarController;
        }
        
        UITabBar.appearance().tintColor = HOMECOLOR;
        UINavigationBar.appearance().barTintColor = HOMECOLOR;
        
        UINavigationBar.appearance().tintColor = HOMECOLOR;
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15),
            NSForegroundColorAttributeName: UIColor.white
        ]
        
        /**
         if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
         
         [[UINavigationBar appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:17], NSFontAttributeName, nil]];
         [[UINavigationBar appearance] setOpaque:YES];
         [[UINavigationBar appearance] setTranslucent: NO];
         
         }
 
        */
        return true
    }

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

    lazy var homeTabbarController: UITabBarController = {
        
        let tab = UITabBarController.init();
        
        let homeVc = HomeViewController();
        homeVc.title = "首页";
        homeVc.tabBarItem = UITabBarItem.init(title: "首页", image:#imageLiteral(resourceName: "home_icon"), selectedImage: #imageLiteral(resourceName: "home_icon"));
        
        let categoriesVc = CategoriesViewController();
        categoriesVc.title = "分类";
        categoriesVc.tabBarItem = UITabBarItem.init(title: "分类", image: #imageLiteral(resourceName: "categories_icon"), selectedImage: #imageLiteral(resourceName: "categories_icon"));
        
        let myVc = MyViewController();
        myVc.title = "我";
        myVc.tabBarItem = UITabBarItem.init(title: "我", image: #imageLiteral(resourceName: "me_icon"), selectedImage: #imageLiteral(resourceName: "me_icon"));
        
        let navH = UINavigationController.init(rootViewController: homeVc);
        let navC = UINavigationController.init(rootViewController: categoriesVc);
        let navM = UINavigationController.init(rootViewController: myVc);
        
        tab.viewControllers = [navH,navC,navM];
        
        return tab;
    }()

}

