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
    var isFollowTag = false
    var tag: FollowedTag?
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
            getTagData()
        default:
            break
        }
    }
    
    private func getTagData() {
        guard let qiitaAPIType = qiitaAPIType else { return }
        
        apiClient.provider.rx.request(qiitaAPIType)
            .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { [weak self] articleAraayResponse in
                do {
                    let tag = try FollowedTag.decode(json: articleAraayResponse.data)
                    self?.tag = tag
                    self?.isSearchTagData()
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
    
    func isSearchTagData() {
        apiClient.provider.rx.request(.followedTag(Defaults.userID))
            .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { [weak self] articleListResponse in
                do {
                    let followedTag = try [FollowedTag].decode(json: articleListResponse.data)
                    
                    if followedTag.map({ $0.id }).contains(self?.tag?.id) {
                        self?.isFollowTag = true
                        self?.reloadRelay.accept(())
                        return
                    }
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
}
