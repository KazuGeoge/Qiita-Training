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
    var article: Observable<(([Article], QiitaAPI))>
    let paging = BehaviorRelay<Int>(value: 1)
    private let disposeBag = DisposeBag()
    
    init(dispatcher: AnyObservableDispatcher<ArticleDispatcher> = .init(.shared)) {
        
        article = dispatcher.article
        
        dispatcher.paging
            .bind(to: paging)
            .disposed(by: disposeBag)
    }
}
