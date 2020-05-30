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
    let tableViewReload = PublishSubject<()>()
    private let disposeBag = DisposeBag()
    private let routeAction: RouteAction
    private let apiClient: APIClient
    
    
    init(routeAction: RouteAction = .shared, apiClient: APIClient = .shared) {
        self.routeAction = routeAction
        self.apiClient = apiClient
    }
    // 検索履歴をUserDefaultsから取り出す。重複を排除する。
    func updateSearchHistory() {
        tagArray = Defaults.searchedTagArray.unique()
        searchedArray = Defaults.searchedArray.unique()
        
        tableViewReload.onNext(())
    }
    
    func showArticleList(qiitaAPI: QiitaAPI) {
        routeAction.show(routeType: .articleList(qiitaAPI))
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
}
