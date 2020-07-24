//
//  ProfileViewModel.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//
import RxSwift
import RxCocoa
import SwiftyUserDefaults

final class ProfileViewModel {
    
    private let apiClient: APIClient
    private let articleAction: ArticleAction
    private let articleStore: ArticleStore
    private let disposeBag = DisposeBag()
    private let reloadRelay = PublishRelay<()>()
    private let userAction: UserAction
    private let userStore: UserStore
    private var userID = ""
    var user: User?
    var otherUserID = ""
    var isSelfUser = true
    var reload: Observable<()> {
        return reloadRelay.asObservable()
    }
    var articleList: [Article] = []
    
    init(apiClient: APIClient = .shared, articleAction: ArticleAction = .shared, articleStore: ArticleStore = .shared, userAction: UserAction = .shared, userStore: UserStore = .shared) {
        self.apiClient = apiClient
        self.articleAction = articleAction
        self.articleStore = articleStore
        self.userAction = userAction
        self.userStore = userStore
        
        observeReloadTriger()
    }
    
    func setUserID() {
        self.userID = isSelfUser ? Defaults.userID : otherUserID
    }
    
    private func getUserPostedArticle() {
        apiClient.provider.rx.request(.userPostedArticle(userID))
            .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { [weak self] articleAraayResponse in
                do {
                    let article = try [Article].decode(json: articleAraayResponse.data)
                    self?.articleAction.article(articleList: article, qiitaAPIType: .userPostedArticle(self?.userID ?? ""))
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
    
    // 記事のAPIとユーザー情報のAPIのレスポンスが揃ったらデータをViewModel内で保持させRelayでイベントを流す
    private func observeReloadTriger() {
        articleStore.article.asObservable()
            .filter { [weak self] article in article.1 == .userPostedArticle(self?.userID ?? "") }
            .withLatestFrom(userStore.user.asObservable()) { ($0, $1) }
            .do(onNext: { [weak self] in self?.articleList = $0.0.0 })
            .do(onNext: { [weak self] in self?.user = $0.1 })
            .map {_ in ()}
            .bind(to: reloadRelay)
            .disposed(by: disposeBag)
    }
    
    func getUserDate() {
        getUserPostedArticle()
        
        apiClient.provider.rx.request(.userProfile(userID))
            .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { [weak self] articleListResponse in
                do {
                    let result = try User.decode(json: articleListResponse.data)
                    self?.userAction.user(user: result)
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
