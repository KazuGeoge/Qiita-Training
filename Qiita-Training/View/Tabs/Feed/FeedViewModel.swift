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
            .subscribe(onSuccess: { articleListResponse in
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let result = try jsonDecoder.decode([Article].self, from: articleListResponse.data)
                    
                    ArticleAction.shared.article(articleList: result, qiitaAPIType: qiitaAPI)
                } catch(let error) {
                    print(error)
                }
            }) { (error) in
                // TODO: エラーイベントを流す
                print(error)
        }
        .disposed(by: self.disposeBag)
    }
}
