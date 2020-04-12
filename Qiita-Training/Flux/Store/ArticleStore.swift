//
//  ArticleStore.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/03/15.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

final class ArticleStore {
    static let shared = ArticleStore()
    var articleStream: Observable<(([Article], QiitaAPI))>
    var heightStream: Observable<CGFloat>
    
    init(dispatcher: AnyObservableDispatcher<ArticleDispatcher> = .init(.shared)) {
        
        articleStream = dispatcher.articleStream
        heightStream = dispatcher.heightStream
    }
}
