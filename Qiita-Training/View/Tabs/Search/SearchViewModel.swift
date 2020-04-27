//
//  SearchViewModel.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import SwiftyUserDefaults
import Foundation

final class SearchViewModel {
    
    var tagArray: [String] = []
    var searchedArray: [String] = []
    
    // 検索履歴をUserDefaultsから取り出す。重複を排除する。
    func updateSearchHistory() {
        tagArray = Defaults.tagArray.unique()
        searchedArray = Defaults.searchedArray.unique()
    }
    
    func showArticleList() {
        RouteAction.shared.show(routeType: .articleList)
    }
}
