//
//  FeedViewModel.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import RxSwift
import RxCocoa

final class FeedViewModel {
    let login: Observable<()>
    private let disposeBag = DisposeBag()
    
    init() {
        login = LoginStore.shared.loginStream.asObservable()
    }
    
    func getAPI(qiitaAPI: QiitaAPI) {
        
        APIClient.shared.call(qiitaAPI: qiitaAPI).asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (articleList: [Article]) in
                
                ArticleAction.shared.article(articleList: articleList)
            })
            .disposed(by: disposeBag)
    }
}
