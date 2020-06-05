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
    private let articleStore: ArticleStore
    private let routeAction: RouteAction
    private let loginStore: LoginStore
    private let reloadSubject = PublishSubject<()>()
    var articleList: [Article] = []
    var qiitaAPIType: QiitaAPI?
    var reload: Observable<()> {
        return reloadSubject.asObservable()
    }
    
    init(articleStore: ArticleStore = .shared, routeAction: RouteAction = .shared, loginStore: LoginStore = .shared) {
        self.articleStore = articleStore
        self.routeAction = routeAction
        self.loginStore = loginStore
        super.init()
        observeReloadTriger()
    }
    
    func observeReloadTriger() {
        articleStore.article.asObservable()
            .filter { [weak self] article in article.1 == self?.qiitaAPIType }
            .do(onNext: { [weak self] article in self?.articleList = article.0 })
            .map {_ in ()}
            .bind(to: reloadSubject)
            .disposed(by: disposeBag)
    }
    
    func showArticleDetail(article: Article) {
        routeAction.show(routeType: .articleDetail(article))
    }
}
