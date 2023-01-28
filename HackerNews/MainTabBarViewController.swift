//
//  MainTabBarViewController.swift
//  HackerNews
//
//  Created by Dimas Wisodewo on 28/01/23.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
                
        let vc1 = UINavigationController(rootViewController: TopViewController())
        let vc2 = UINavigationController(rootViewController: AskViewController())
        let vc3 = UINavigationController(rootViewController: ShowViewController())
        let vc4 = UINavigationController(rootViewController: JobViewController())
        
        // Add icons
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "questionmark")
        vc3.tabBarItem.image = UIImage(systemName: "doc")
        vc4.tabBarItem.image = UIImage(systemName: "briefcase")

        // Add titles
        vc1.title = "Top Stories"
        vc2.title = "Ask Stories"
        vc3.title = "Show Stories"
        vc4.title = "Job Stories"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }
    
}
