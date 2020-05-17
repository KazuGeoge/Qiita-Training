//
//  FeedViewModel.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import RxSwift
import RxCocoa
import RxMoya

final class FeedViewModel {
    let login: Observable<()>
    private let disposeBag = DisposeBag()
    private let loginStore: LoginStore
    private let apiClient: APIClient
    
    init(loginStore: LoginStore = .shared, apiClient: APIClient = .shared) {
        self.loginStore = loginStore
        self.apiClient = apiClient
        login = loginStore.login.asObservable()
        observeLoginStore()
    }
    
    func getAPI(qiitaAPI: QiitaAPI?) {
        
        guard let qiitaAPI = qiitaAPI else { return }
                
        apiClient.provider.rx.request(qiitaAPI)
            .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { articleListResponse in
                do {
                    let result = try [Article].decode(json: articleListResponse.data)
                    ArticleAction.shared.article(articleList: result, qiitaAPIType: qiitaAPI)
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
    private func observeLoginStore() {
        loginStore.login.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.getAPI(qiitaAPI: .followArticle)
                self?.getAPI(qiitaAPI: .stockArticle)
            })
            .disposed(by: self.disposeBag)
    }
}
