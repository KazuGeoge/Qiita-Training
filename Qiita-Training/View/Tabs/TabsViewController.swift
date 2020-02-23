//
//  ViewController.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/01/12.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TabsViewController: UITabBarController {

    private let disposeBag = DisposeBag()
    private let viewModel = TabsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBarItem()
        observeViewModel()
    }
    
    private func configureTabBarItem() {
        guard let feed = UIStoryboard(name: "Feed", bundle: nil).instantiateViewController(withIdentifier: "Feed") as? FeedViewController,
            let search =  UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "Search") as? SearchViewController,
            let setting = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "Profile") as? ProfileViewController else { return }
        
        feed.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 1)
        search.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        setting.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 3)
        
        self.viewControllers = [feed, search, setting].map {
            UINavigationController(rootViewController: $0)
        }
    }
    
    private func observeViewModel() {
        
        viewModel.display.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { routeType in
                guard let routeType = routeType else { return }
                switch routeType {
                case .articleDetail:
                    guard let articleDetailViewController = UIStoryboard(name: "ArticleDetail", bundle: nil)
                        .instantiateViewController(withIdentifier: "ArticleDetail") as? ArticleDetailViewController,
                        let topViewController = UIApplication.topViewController() else { return }
                    
                    topViewController.navigationController?.pushViewController(articleDetailViewController, animated: true)
                case .articleList:
                    guard let articleListViewController = UIStoryboard(name: "ArticleList", bundle: nil)
                        .instantiateViewController(withIdentifier: "ArticleList") as? ArticleListViewController,
                        let topViewController = UIApplication.topViewController() else { return }
                    
                    topViewController.navigationController?.pushViewController(articleListViewController, animated: true)
                case .profileDetail(let profileType):
                    guard let profileDetailViewController = UIStoryboard(name: "ProfileDetail", bundle: nil)
                        .instantiateViewController(withIdentifier: "ProfileDetail") as? ProfileDetailViewController,
                        let topViewController = UIApplication.topViewController() else { return }
                    
                    profileDetailViewController.viewModel.profileType = profileType
                    topViewController.navigationController?.pushViewController(profileDetailViewController, animated: true)
                case .profile:
                    guard let profileDetailViewController = UIStoryboard(name: "Profile", bundle: nil)
                        .instantiateViewController(withIdentifier: "Profile") as? ProfileViewController,
                        let topViewController = UIApplication.topViewController() else { return }
                    
                    topViewController.navigationController?.pushViewController(profileDetailViewController, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}
