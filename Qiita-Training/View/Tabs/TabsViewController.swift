//
//  ViewController.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/01/12.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit

class TabsViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBarItem()
    }
    
    private func configureTabBarItem() {
        guard let feed = UIStoryboard(name: "Feed", bundle: nil).instantiateViewController(withIdentifier: "Feed") as? FeedViewController,
            let search =  UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "Search") as? SearchViewController,
            let setting = UIStoryboard(name: "Setting", bundle: nil).instantiateViewController(withIdentifier: "Setting") as? SettingViewController else { return }
        
        feed.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 1)
        search.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        setting.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 3)
        
        self.viewControllers = [feed, search, setting].map {
            UINavigationController(rootViewController: $0)
        }
    }
}
