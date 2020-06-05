//
//  ArticleDispatcher.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/03/15.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit
// データフローを単一方向に保つ
final class ArticleDispatcher: DispatcherType {
       static let shared = ArticleDispatcher()
        
        fileprivate let article = PublishSubject<(([Article], QiitaAPI))>()
        
        private init() {}
}

// onNextだけができるDispathcher
extension AnyObserverDispatcher where Dispatcher: ArticleDispatcher {
    var article: AnyObserver<(([Article], QiitaAPI))> {
        return dispatcher.article.asObserver()
    }
}

// subscribeだけができるDispatcher
extension AnyObservableDispatcher where Dispatcher: ArticleDispatcher {
    var article: Observable<(([Article], QiitaAPI))> {
        return dispatcher.article
    }
}
