//
//  ArticleListViewModel.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/04/27.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import RxSwift
import RxCocoa
import SwiftyUserDefaults

final class ArticleListViewModel: NSObject {

    private let disposeBag = DisposeBag()
    private let articleStore: ArticleStore
    private let routeAction: RouteAction
    private let loginStore: LoginStore
    private let reloadRelay = PublishRelay<()>()
    private let apiClient: APIClient
    var articleList: [Article] = []
    var qiitaAPIType: QiitaAPI?
    var isSearchTag = false
    var isLoding = false
    var isEmptyContentList = false
    var reload: Observable<()> {
        return reloadRelay.asObservable()
    }
    
    init(articleStore: ArticleStore = .shared, routeAction: RouteAction = .shared, loginStore: LoginStore = .shared, apiClient: APIClient = .shared) {
        self.articleStore = articleStore
        self.routeAction = routeAction
        self.loginStore = loginStore
        self.apiClient = apiClient
        super.init()
        observeReloadTriger()
    }
    
    func observeReloadTriger() {
        articleStore.article.asObservable()
            .filter { [weak self] article in article.1 == self?.qiitaAPIType }
            .do(onNext: { [weak self] article in self?.articleList = article.0 })
            .map {_ in ()}
            .bind(to: reloadRelay)
            .disposed(by: disposeBag)
    }
    
    func showArticleDetail(article: Article) {
        routeAction.show(routeType: .articleDetail(article))
    }
    
    func setIsSearchTag() {
        switch qiitaAPIType {
        case .searchTag:
            isSearchTag = true
            reloadRelay.accept(())
        default:
            break
        }
    }
    
    func callAPI() {
        guard let qiitaAPI = qiitaAPIType else { return }
        apiClient.provider.rx.request(qiitaAPI)
            .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { [weak self] response in
                do {
                    self?.articleList += try [Article].decode(json: response.data)
                    self?.reloadRelay.accept(())
                } catch(let error) {
                    // TODO: エラーイベントを流す
                    print(error)
                }
            })
            .disposed(by: self.disposeBag)
    }
}
