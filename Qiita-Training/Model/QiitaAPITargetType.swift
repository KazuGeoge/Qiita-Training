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
    case followTagArticle([String])
    case stockArticle
    case searchWord(String)
    case searchTag(String)
    case authenticatedUser
    case followTag
}

extension QiitaAPI: TargetType {
    
    var baseURL: URL {
        // TODO: OptionalBindingの方法が分からない。nilで帰ってきたらどうするか？
        return URL(string:"https://qiita.com")!
    }
    
    // TODO: ページングするため、叩くAPIは指定するページを更新出来るようにする
    var path: String {
        switch self {
        case .newArticle, .followTagArticle, .searchWord, .searchTag:
            return "/api/v2/items"
        case .stockArticle:
            return "/api/v2/users/\(Defaults.userID)/stocks"
        case .authenticatedUser:
            return "/api/v2/authenticated_user"
        case .followTag:
            return "api/v2/users/\(Defaults.userID)/following_tags"
        }
    }

    var method: Moya.Method {
        switch self {
        case .newArticle, .followTagArticle, .stockArticle, .searchTag, .searchWord, .authenticatedUser, .followTag:
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
        case .followTagArticle(let followedTagArray):
            let joinedTagArray = followedTagArray.joined(separator:  " OR tag:")
            paramerter = ["query": "tag:\(joinedTagArray)"]
        case .searchWord(let searchWord):
            paramerter = ["query": searchWord]
        case .searchTag(let tagWord):
            paramerter = ["query": "tag:\(tagWord)"]
        case .newArticle, .stockArticle, .authenticatedUser, .followTag:
            return .requestPlain
        }
        
        return .requestParameters(parameters: paramerter, encoding: URLEncoding.default)
    }

    var headers: [String : String]? {
        var paramerter: [String: String] = [:]
        
        switch self {
        case .newArticle, .searchWord, .searchTag, .followTag:
            break
        case .followTagArticle, .stockArticle, .authenticatedUser:
            paramerter = ["Authorization":"Bearer \(Defaults.token)"]
        }
        return  paramerter
    }
}
