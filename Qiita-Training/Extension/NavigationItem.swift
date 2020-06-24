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
    case rightTeam
    case profile
    case profileDetail
    case rightBack
    case leftBack
}

extension UINavigationItem {

    func configure(navigationItemType: NavigationItemType, disposeBag: DisposeBag, title: String) {
        
        titleView = generateTitleLabel(title: title)
        // TODO: その他の分岐方法は後ほど実装する。
        switch navigationItemType {
        case .profile:
            let shareButtonItem = UIBarButtonItem(title: "⚙", style: .plain, target: self, action: nil)
            rightBarButtonItems = [shareButtonItem]
            shareButtonItem.rx.tap
                .subscribe(onNext: { _ in
                    print("設定のタップ")
                })
                .disposed(by: disposeBag)
            
            backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            backBarButtonItem?.tintColor = .white
        default:
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
