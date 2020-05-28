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
    var articleList: [Article] = []
    private let loginStore: LoginStore
    
    init(articleStore: ArticleStore = .shared, routeAction: RouteAction = .shared, loginStore: LoginStore = .shared) {
        self.articleStore = articleStore
        self.routeAction = routeAction
        self.loginStore = loginStore
    }
    
    func observeArticleStore(qiitaAPIType: QiitaAPI?) -> Observable<()> {
        return Observable.create { [weak self] observer in
            
            if let disposeBag = self?.disposeBag {
                self?.articleStore.article.asObservable()
                    .filter { $0.1 == qiitaAPIType }
                    .subscribe(onNext: { [weak self] article in
                        self?.articleList = article.0
                        observer.onNext(())
                    })
                    .disposed(by: disposeBag)
            }
            return Disposables.create()
        }
    }
    
    func showArticleDetail(article: Article) {
        routeAction.show(routeType: .articleDetail(article))
    }
}
