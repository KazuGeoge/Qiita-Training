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
    private let disposeBag = DisposeBag()
    
    init(apiClient: APIClient = .shared, articleAction: ArticleAction = .shared) {
        self.apiClient = apiClient
        self.articleAction = articleAction
    }
    
    func getUserPostedArticle() {
        apiClient.provider.rx.request(.userPostedArticle)
            .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { articleAraayResponse in
                do {
                    let article = try [Article].decode(json: articleAraayResponse.data)
                    articleAction.article(articleList: article, qiitaAPIType: .userPostedArticle)
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
