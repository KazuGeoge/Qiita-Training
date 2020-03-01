//
//  FeedViewController.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit
import SwipeMenuViewController
import RxSwift
import RxCocoa

enum FeedType: CaseIterable {
    case new
    case fellow
    case stock
    
    var text: String {
        switch self {
        case .new:
            return "新着"
        case .fellow:
            return "フォロー中"
        case .stock:
            return "ストック済み"
        }
    }
}

class FeedViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    @IBOutlet private weak var swipeMenuView: SwipeMenuView!
    private let viewModel = FeedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSwipeMenuView()
        observeViewModel()
    }
    
    private func observeViewModel() {
        viewModel.login.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.setUpSwipeMenuView()
            })
            .disposed(by: disposeBag)
    }
    
    func setUpSwipeMenuView() {
        var options: SwipeMenuViewOptions = .init()
        options.tabView.style = .segmented
        options.tabView.additionView.backgroundColor = .green
        
        swipeMenuView.dataSource = self
        swipeMenuView.reloadData(options: options)
    }
}

extension FeedViewController: SwipeMenuViewDataSource {
    func numberOfPages(in swipeMenuView: SwipeMenuView) -> Int {
        return FeedType.allCases.count
    }

    func swipeMenuView(_ swipeMenuView: SwipeMenuView, titleForPageAt index: Int) -> String {
        return FeedType.allCases[index].text
    }

    // ログイン状況に合わせてと返すViewContorollerを制御する
    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
       
        var viewController = UIViewController()
        // 新着記事はログイン状態に関わるず出すため、indexが0の時は必ずtrueになるようにする。
        let isArticleList = UserDefaults.standard.bool(forKey: "is_login_user") || index == 0
        let stiryboardName = isArticleList ? ViewControllerType.articleList.storyboardName : ViewControllerType.stillLogin.storyboardName
        let childViewController =  UIStoryboard(name: stiryboardName, bundle: nil).instantiateViewController(withIdentifier: stiryboardName)
        childViewController.title = FeedType.allCases[index].text
        
        let castedChildViewController = isArticleList ? childViewController as? ArticleListViewController:
                                                        childViewController as? StillLoginUserViewController
        
        if let castedChildViewController = castedChildViewController {
            addChild(castedChildViewController)
            viewController = castedChildViewController
        }
        
        return viewController
    }
}
