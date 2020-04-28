//
//  MainTabBarController.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 3/30/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {


    lazy var favoritesVC = UINavigationController(rootViewController: FavoritesVC())
  
    lazy var browseVC =  UINavigationController(rootViewController: BrowseVC())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
    private func setUpTabBar(){
        browseVC.tabBarItem = UITabBarItem(title: "Recipes", image: UIImage(systemName: "magnifyingglass.circle"), tag: 0)
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 1)
        self.viewControllers = [browseVC,favoritesVC]
    }
}
