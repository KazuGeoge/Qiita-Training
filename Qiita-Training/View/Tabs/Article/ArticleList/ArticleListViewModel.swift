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
    
    func observeArticleStore(qiitaAPIType: QiitaAPI?) {
        ArticleStore.shared.article.asObservable()
            .observeOn(MainScheduler.instance)
            .filter { $0.1 == qiitaAPIType }
            .subscribe(onNext: { [weak self] article in
                self?.articleList = article.0
//                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    func showArticleDetail(article: Article) {
        RouteAction.shared.show(routeType: .articleDetail(article))
    }
}
