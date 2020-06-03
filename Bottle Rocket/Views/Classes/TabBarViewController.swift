//
//  TabBarViewController.swift
//  Bottle Rocket
//
//  Created by Subhankar Ghosh on 30/05/20.
//  Copyright © 2020 Subhankar Ghosh. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
    }
    
    func configureTabs() {
        tabBar.barTintColor = UIColor.init(rgb: 0x2A2A2A)
        tabBar.unselectedItemTintColor = UIColor.init(rgb: 0x979797)
        tabBar.tintColor = .white
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let lunchViewController = mainStoryboard.instantiateViewController(withIdentifier: Strings.ViewControllerIdentifier.lunchViewController) as? LunchViewController else {return}
        let internetViewController = InternetViewController()
        
        let lunchNavigation = UINavigationController(rootViewController: lunchViewController)
        lunchNavigation.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.init(rgb: 0xFFFFFF)]
        let internetNavigation = UINavigationController(rootViewController: internetViewController)
        lunchNavigation.navigationBar.barTintColor = UIColor.init(rgb: 0x43E895)
        lunchNavigation.navigationBar.tintColor = UIColor.init(rgb: 0xFFFFFF)
        internetNavigation.navigationBar.barTintColor = UIColor.init(rgb: 0x43E895)
        internetNavigation.navigationBar.tintColor = UIColor.init(rgb: 0xFFFFFF)
        lunchViewController.tabBarItem = UITabBarItem.init(title: "lunch", image: UIImage(named: "lunch"), tag: 0)
        internetViewController.tabBarItem = UITabBarItem.init(title: "internets", image: UIImage(named: "internet"), tag: 1)
        self.viewControllers = [lunchNavigation, internetNavigation]
    }
}
