//
//  SearchViewModel.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import SwiftyUserDefaults

final class SearchViewModel {
    
    var tagArray: [String] = []
    var searchedArray: [String] = []
    
    func updateSearchHistory() {
        tagArray = Defaults.tagArray
        searchedArray = Defaults.searchedArray
    }
}
