//
//  TabBarController.swift
//  Harmonica Tabs
//
//  Created by Ho Duy Luong on 5/18/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabbar()
    }
    
    func setTabbar() {
        let listVC = ListTabsViewController(nibName: nil, bundle: nil)
        let favoriteVC = FavoriteListViewController(nibName: nil, bundle: nil)
        let settingVC = SettingViewController(nibName: nil, bundle: nil)
        
        let listNav = UINavigationController(rootViewController: listVC)
        listNav.tabBarItem.title = "Tabs"
        listNav.tabBarItem.image = UIImage(systemName: "list.bullet")?.withRenderingMode(.alwaysOriginal)
        listNav.tabBarItem.selectedImage = UIImage(systemName: "list.bullet.indent")?.withRenderingMode(.alwaysOriginal)
        listNav.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        let favoriteNav = UINavigationController(rootViewController: favoriteVC)
        favoriteNav.tabBarItem.title = "Favorites"
        favoriteNav.tabBarItem.image = UIImage(systemName: "suit.heart")?.withRenderingMode(.alwaysOriginal)
        favoriteNav.tabBarItem.selectedImage = UIImage(systemName: "suit.heart.fill")?.withRenderingMode(.alwaysOriginal)
        favoriteNav.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        let settingNav = UINavigationController(rootViewController: settingVC)
        settingNav.tabBarItem.title = "Setting"
        settingNav.tabBarItem.image = UIImage(systemName: "gear")?.withRenderingMode(.alwaysOriginal)
        settingNav.tabBarItem.selectedImage = UIImage(systemName: "gear")?.withRenderingMode(.alwaysOriginal)
        settingNav.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        viewControllers = [listNav, favoriteNav, settingNav]
        tabBar.barTintColor = UIColor.flatMintDark()
        tabBar.backgroundColor = UIColor.flatCoffeeDark()
        tabBar.unselectedItemTintColor = UIColor.flatGrayDark()
        tabBar.tintColor = UIColor.flatMintDark()
    
        let appearance = UITabBarAppearance()
        
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.flatGrayDark()
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.flatMintDark()
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.flatMint()]
        appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        appearance.stackedLayoutAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)

        appearance.inlineLayoutAppearance.normal.iconColor = UIColor.flatGrayDark()
        appearance.inlineLayoutAppearance.selected.iconColor = UIColor.flatMintDark()
        appearance.inlineLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.flatMint()]

        appearance.compactInlineLayoutAppearance.normal.iconColor = UIColor.flatGrayDark()
        appearance.compactInlineLayoutAppearance.selected.iconColor = UIColor.flatMintDark()
        appearance.compactInlineLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.flatMint()]

        
        appearance.backgroundColor = UIColor.flatCoffeeDark()
        tabBar.standardAppearance = appearance
        
    }
    
}
