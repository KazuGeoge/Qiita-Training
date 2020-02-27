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
                guard let routeType = routeType, let topViewController = UIApplication.topViewController() else { return }
                
                var viewContoroller: UIViewController?
                
                switch routeType {
                case .articleDetail:
                    viewContoroller = ViewControllerBuilder.shared.configureViewController(viewControllerType: .articleDetail) as? ArticleDetailViewController
                case .articleList:
                    viewContoroller = ViewControllerBuilder.shared.configureViewController(viewControllerType: .articleList) as? ArticleListViewController
                case .profile:
                    viewContoroller = ViewControllerBuilder.shared.configureViewController(viewControllerType: .profile) as? ProfileViewController
                case .profileDetail(let profileType):
                    let profileDetailViewController = ViewControllerBuilder.shared.configureViewController(viewControllerType: .profileDetail) as? ProfileDetailViewController
                    profileDetailViewController?.viewModel.profileType = profileType
                    
                    viewContoroller = profileDetailViewController
                }
                
                if let viewContoroller = viewContoroller {
                    topViewController.navigationController?.pushViewController(viewContoroller, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}
