//
//  ViewControllerBuilder.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/22.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import  UIKit

enum ViewControllerType {
    case feed
    case search
    case setting
    case articleDetail
    case articleList
    case profileDetail
    case profile
    
    // TODO: マージ後storyboardNameをViewControllerに合わせる
    var storyboardName: String {
        switch self {
        case .feed:
            return "Feed"
        case .search:
            return "Search"
        case .setting:
            return "Setting"
        case .articleDetail:
            return "ArticleDetail"
        case .articleList:
            return "ArticleList"
        case .profileDetail:
            return "ProfileDetail"
        case .profile:
            return "Profile"
        }
    }
}

class ViewControllerBuilder {
    static let shared = ViewControllerBuilder()

    func configureViewController(viewControllerType: ViewControllerType) -> UIViewController? {
        
        let viewController = UIStoryboard(name: viewControllerType.storyboardName, bundle: nil).instantiateViewController(withIdentifier: viewControllerType.storyboardName)
        
        return viewController
    }
}
