//
//  ProfileViewModel.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//
import RxSwift
import RxCocoa

final class ProfileViewModel {
    
    private let apiClient: APIClient
    private let articleAction: ArticleAction
    private let articleStore: ArticleStore
    private let disposeBag = DisposeBag()
    private let reloadSubject = PublishSubject<()>()
    var reload: Observable<()> {
        return reloadSubject.asObservable()
    }
    var articleList: [Article] = []
    
    init(apiClient: APIClient = .shared, articleAction: ArticleAction = .shared, articleStore: ArticleStore = .shared) {
        self.apiClient = apiClient
        self.articleAction = articleAction
        self.articleStore = articleStore
        
        observeReloadTriger()
    }
    
    func getUserPostedArticle() {
        apiClient.provider.rx.request(.userPostedArticle)
            .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: {[weak self] articleAraayResponse in
                do {
                    let article = try [Article].decode(json: articleAraayResponse.data)
                    self?.articleAction.article(articleList: article, qiitaAPIType: .userPostedArticle)
                } catch(let error) {
                    // TODO: エラーイベントを流す
                    print(error)
                }
            }) { (error) in
                // TODO: エラーイベントを流す
                print(error)
        }
        .disposed(by: self.disposeBag)
    }
    
    private func observeReloadTriger() {
        articleStore.article.asObservable()
            .filter { article in article.1 == .userPostedArticle }
            .do(onNext: { [weak self] article in self?.articleList = article.0 })
            .map {_ in ()}
            .bind(to: reloadSubject)
            .disposed(by: disposeBag)
    }
}
