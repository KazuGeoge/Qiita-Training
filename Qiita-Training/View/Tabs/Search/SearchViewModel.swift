//
//  SearchViewModel.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import SwiftyUserDefaults
import Foundation
import RxSwift
import RxCocoa
import RxMoya

final class SearchViewModel {
    
    var tagArray: [String] = []
    var searchedArray: [String] = []
    private let disposeBag = DisposeBag()
    
    // 検索履歴をUserDefaultsから取り出す。重複を排除する。
    func updateSearchHistory() {
        tagArray = Defaults.tagArray.unique()
        searchedArray = Defaults.searchedArray.unique()
    }
    
    func showArticleList(qiitaAPI: QiitaAPI) {
        RouteAction.shared.show(routeType: .articleList(qiitaAPI))
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
