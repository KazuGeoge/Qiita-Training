//
//  FeedViewController.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit
import SwipeMenuViewController

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setUpSwipeMenuView()
    }
    
    func setUpSwipeMenuView() {
        
        let statusBarHeight = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let navigationBarHeight = navigationController?.navigationBar.frame.size.height ?? 0
        
        let swipeMenuView = SwipeMenuView(frame: CGRect(x: 0, y: statusBarHeight + navigationBarHeight, width: view.frame.width, height: view.frame.height))
        swipeMenuView.dataSource = self
                
        view.addSubview(swipeMenuView)
        
        var options: SwipeMenuViewOptions = .init()
        options.tabView.style = .segmented
        options.tabView.additionView.backgroundColor = .green
        
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

    func swipeMenuView(_ swipeMenuView: SwipeMenuView, viewControllerForPageAt index: Int) -> UIViewController {
        
        var viewController = UIViewController()
        
        if let articleListViewController =  UIStoryboard(name: "ArticleList", bundle: nil).instantiateViewController(withIdentifier: "ArticleList") as? ArticleListViewController {
            
            viewController = articleListViewController
        }
        return viewController
    }
}
