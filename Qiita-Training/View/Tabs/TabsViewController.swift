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
import SwiftyUserDefaults

class TabsViewController: UITabBarController {

    private let disposeBag = DisposeBag()
    private let viewModel = TabsViewModel()
    private var viewControllerArray: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBarItem()
        observeViewModel()
    }
    
    private func configureTabBarItem() {
        guard let feed = UIStoryboard(name: ViewControllerType.feed.storyboardName, bundle: nil).instantiateViewController(withIdentifier: ViewControllerType.feed.storyboardName) as? FeedViewController,
            let search =  UIStoryboard(name: ViewControllerType.search.storyboardName, bundle: nil).instantiateViewController(withIdentifier: ViewControllerType.search.storyboardName) as? SearchViewController,
            let profile = Defaults.isLoginUdser ?
                UIStoryboard(name: ViewControllerType.profile.storyboardName, bundle: nil).instantiateViewController(withIdentifier: ViewControllerType.profile.storyboardName) as? ProfileViewController :
                UIStoryboard(name: ViewControllerType.stillLogin.storyboardName, bundle: nil).instantiateViewController(withIdentifier: ViewControllerType.stillLogin.storyboardName) as? StillLoginUserViewController else { return }
        
        feed.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 1)
        search.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        profile.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 3)
        
        viewControllerArray = [feed, search, profile]
        resisterRootViewController()
        
        if Defaults.isLoginUdser {
            LoginAction.shared.login()
        }

        viewModel.loginActionIfNeeded()
    }
    
    private func resisterRootViewController() {
        self.viewControllers = viewControllerArray.map {
            UINavigationController(rootViewController: $0)
        }
    }
    
    private func observeViewModel() {
        
        viewModel.display.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] routeType in
                guard let routeType = routeType, let topViewController = UIApplication.topViewController() else { return }
                
                var viewContoroller: UIViewController?
                
                switch routeType {
                case .articleDetail(let article):
                    let articleDetailViewController = ViewControllerBuilder.shared.configureViewController(viewControllerType: .articleDetail) as? ArticleDetailViewController
                    articleDetailViewController?.article = article
                    viewContoroller = articleDetailViewController
                case .articleList(let qiitaAPI):
                    let articleListViewController = ViewControllerBuilder.shared.configureViewController(viewControllerType: .articleList) as? ArticleListViewController
                    articleListViewController?.qiitaAPIType = qiitaAPI
                    viewContoroller = articleListViewController
                case .profile:
                    viewContoroller = ViewControllerBuilder.shared.configureViewController(viewControllerType: .profile) as? ProfileViewController
                case .profileDetail(let profileType):
                    let profileDetailViewController = ViewControllerBuilder.shared.configureViewController(viewControllerType: .profileDetail) as? ProfileDetailViewController
                    profileDetailViewController?.viewModel.profileType = profileType
                case .stillLogin:
                    viewContoroller = ViewControllerBuilder.shared.configureViewController(viewControllerType: .stillLogin) as? StillLoginUserViewController
                case .login:
                    if let loginViewContoroller = ViewControllerBuilder.shared.configureViewController(viewControllerType: .login) as? AuthenticationViewController {
                    
                        self?.present(loginViewContoroller, animated: true, completion: nil)
                    }
                }
                
                if let viewContoroller = viewContoroller {
                    topViewController.navigationController?.pushViewController(viewContoroller, animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.login.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                
                if let profile = UIStoryboard(name: ViewControllerType.profile.storyboardName, bundle: nil)
                    .instantiateViewController(withIdentifier: ViewControllerType.profile.storyboardName) as? ProfileViewController {
                    
                    profile.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 3)
                    self?.viewControllerArray.remove(at: 2)
                    self?.viewControllerArray.append(profile)
                    
                    self?.viewControllers = self?.viewControllerArray.map {
                        UINavigationController(rootViewController: $0)
                    }
                    
                    self?.resisterRootViewController()
                }
            })
            .disposed(by: disposeBag)
    }
}
