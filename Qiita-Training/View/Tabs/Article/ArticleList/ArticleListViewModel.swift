//
//  ArticleListViewModel.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/04/27.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import RxSwift
import RxCocoa

final class ArticleListViewModel: NSObject {

    private let disposeBag = DisposeBag()
    var articleList: [Article] = []
    var reloadTableView: Observable<()>
    private let articleStore: ArticleStore
    private let routeAction: RouteAction
    
    init(articleStore: ArticleStore = .shared, routeAction: RouteAction = .shared) {
        self.articleStore = articleStore
        self.routeAction = routeAction
    }
    
    func observeArticleStore(qiitaAPIType: QiitaAPI?) {
                articleStore.article.asObservable()
                    .filter { $0.1 == qiitaAPIType }
                    .do(onNext: { [weak self] in self?.articleList = $0.0 })
                    .bind(to: reloadTableView)
                    .disposed(by: disposeBag)
    }
    
    func showArticleDetail(article: Article) {
        routeAction.show(routeType: .articleDetail(article))
    }
}
