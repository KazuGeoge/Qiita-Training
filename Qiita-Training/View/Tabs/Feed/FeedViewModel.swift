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
    
    init() {
        login = LoginStore.shared.login.asObservable()
    }
    
    func getAPI(qiitaAPI: QiitaAPI?) {
        
        guard let qiitaAPI = qiitaAPI else { return }
                
        APIClient.shared.provider.rx.request(qiitaAPI)
            .filterSuccessfulStatusCodes()
            .map([Article].self)
            .subscribe(onSuccess: { articleList in
                ArticleAction.shared.article(articleList: articleList, qiitaAPIType: qiitaAPI)
            }) { (error) in
                // TODO: エラーイベントを流す
                print(error)
        }
        .disposed(by: self.disposeBag)
    }
}
