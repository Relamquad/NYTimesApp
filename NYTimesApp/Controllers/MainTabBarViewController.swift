//
//  MainTabBarViewController.swift
//  NYTimesApp
//
//  Created by Konstantin Kalivod on 5/27/19.
//  Copyright © 2019 Kostya Kalivod. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate{
    var myArticleList : Array = [Article]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
       setupTabBar()

        


        // Do any additional setup after loading the view.
    }
    
    func setupTabBar() {
        
        let emailedController = UINavigationController(rootViewController: EmailedTableViewController())
        emailedController.tabBarItem.image = UIImage(named: "email-7")
        emailedController.tabBarItem.title = "Emailed"
        emailedController.tabBarItem.tag = 1

        let sharedController = UINavigationController(rootViewController: EmailedTableViewController())
        sharedController.tabBarItem.image = UIImage(named: "paper-plane-7")
        sharedController.tabBarItem.title = "Shared"
        sharedController.tabBarItem.tag = 2
        
        let viewedController = UINavigationController(rootViewController: EmailedTableViewController())
        viewedController.tabBarItem.image = UIImage(named: "earth-america-7")
        viewedController.tabBarItem.title = "Viewed"
        viewedController.tabBarItem.tag = 3
        
        let myFavoriteController = UINavigationController(rootViewController: EmailedTableViewController())
        myFavoriteController.tabBarItem.image = UIImage(named: "star-7")
        myFavoriteController.tabBarItem.title = "Favorite"
        myFavoriteController.tabBarItem.tag = 4
        
        viewControllers = [emailedController, sharedController, viewedController, myFavoriteController]
    }

}
