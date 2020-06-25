//
//  NavigationItem.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/06/23.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

enum NavigationItemType {
    case profile
    case profileDetail
    case setting
}

extension UINavigationItem {

    func configure(navigationItemType: NavigationItemType, disposeBag: DisposeBag, title: String) {
        
        let routeAction = RouteAction.shared
        
        titleView = generateTitleLabel(title: title)
        // TODO: その他の分岐方法は後ほど実装する。
        switch navigationItemType {
        case .profile:
            let shareButtonItem = UIBarButtonItem(title: "⚙", style: .plain, target: self, action: nil)
            rightBarButtonItems = [shareButtonItem]
            backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            backBarButtonItem?.tintColor = .white
            
            shareButtonItem.rx.tap
                .subscribe(onNext: { _ in
                    routeAction.show(routeType: .setting)
                })
                .disposed(by: disposeBag)
          
            
        case .setting:
            let backButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: nil)
            rightBarButtonItems = [backButton]
            
            backButton.rx.tap
                .subscribe(onNext: { _ in
                    routeAction.show(routeType: .dismiss)
                })
                .disposed(by: disposeBag)
        case .profileDetail:
            break
        }
    }
    
    func generateTitleLabel(title: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.text = title
        
        return titleLabel
    }
}
