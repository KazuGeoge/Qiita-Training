//
//  ArticleAction.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/03/15.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit

final class ArticleAction {
    static let shared = ArticleAction()
    private let dispatcher: AnyObserverDispatcher<ArticleDispatcher>
    
    init(dispatcher: AnyObserverDispatcher<ArticleDispatcher> = .init(.shared)) {
        self.dispatcher = dispatcher
    }
    
    func article(articleList: [Article], qiitaAPIType: QiitaAPI) {
        dispatcher.article.onNext((articleList, qiitaAPIType))
    }
}
