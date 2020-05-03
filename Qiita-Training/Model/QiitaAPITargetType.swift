//
//  QiitaAPITargetType.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/03/15.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import Moya
import SwiftyUserDefaults

enum QiitaAPI: Equatable {
    case newArticle
    case followArticle
    case stockArticle
    case searchWord(String)
    case searchTag(String)
}

extension QiitaAPI: TargetType {
    
    var baseURL: URL {
        // TODO: OptionalBindingの方法が分からない。nilで帰ってきたらどうするか？
        return URL(string:"https://qiita.com")!
    }
    
    // TODO: ページングするため、叩くAPIは指定するページを更新出来るようにする
    var path: String {
        switch self {
        case .newArticle, .searchWord, .searchTag:
            return "/api/v2/items"
        case .followArticle:
            return "/users/\(Defaults.token)/items?page=1&per_page=20"
        case .stockArticle:
            return "/users/\(Defaults.token)/stocks?page=1&per_page=20"
        }
    }

    var method: Moya.Method {
        switch self {
        case .newArticle, .followArticle, .stockArticle, .searchTag, .searchWord:
            return .get
        }
    }

    //テストの際テスト用のjsonを返すことができるメソッド
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        var paramerter: [String: Any] = [:]
        
        switch self {
        case .searchWord(let searchWord):
            paramerter = ["query": searchWord]
        case .searchTag(let tagWord):
            paramerter = ["query": "tag:\(tagWord)"]
        case .newArticle, .followArticle, .stockArticle:
            return .requestPlain
        }
        
        return .requestParameters(parameters: paramerter, encoding: URLEncoding.default)
    }

    var headers: [String : String]? {
        return nil
    }
}
