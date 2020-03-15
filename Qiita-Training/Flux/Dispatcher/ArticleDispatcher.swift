//
//  ArticleDispatcher.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/03/15.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import RxSwift
import RxCocoa

// データフローを単一方向に保つ
final class ArticleDispatcher: DispatcherType {
       static let shared = ArticleDispatcher()
        
        fileprivate let articleStream = PublishSubject<([Article])>()
        
        private init() {}
}

// onNextだけができるDispathcher
extension AnyObserverDispatcher where Dispatcher: ArticleDispatcher {
    var articleStream: AnyObserver<([Article])> {
        return dispatcher.articleStream.asObserver()
    }
}

// subscribeだけができるDispatcher
extension AnyObservableDispatcher where Dispatcher: ArticleDispatcher {
    var articleStream: Observable<([Article])> {
        return dispatcher.articleStream
    }
}
