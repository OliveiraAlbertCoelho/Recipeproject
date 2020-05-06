//
//  MainTabBarController.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 3/30/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController{
   
   
   lazy var favoritesVC = UINavigationController(rootViewController: FavoritesVC())
   lazy var discoverVC =  UINavigationController(rootViewController: DiscoverVC())
   lazy var cartVC = UINavigationController(rootViewController: CartVC())
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setUpTabBar()
      tabBar.tintColor = .orange
      tabBar.unselectedItemTintColor = .orange
   }
   private func setUpTabBar(){
      
      discoverVC.tabBarItem = UITabBarItem(title: "Recipes", image: UIImage(systemName: "magnifyingglass.circle"), tag: 0)
      favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 1)
      cartVC.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart"), tag: 2)
      self.viewControllers = [discoverVC,cartVC, favoritesVC]
   }
   
}
