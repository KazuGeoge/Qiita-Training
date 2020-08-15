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
    case newArticle(Int)
    case followedTagArticle([String], Int)
    case stockArticle(String, Int)
    case searchWord(String, Int)
    case searchTag(String)
    case authenticatedUser
    case userProfile(String)
    case followedTag(String)
    case userPostedArticle(String, Int)
    case followUsers(String)
    case followerUsers(String)
    // 実際にAPIは叩かないが識別のため追加
    case browsingHistory
    
    mutating func addPage(page: Int) {
        switch self {
        case .newArticle:
            self = .newArticle(page)
        case .followedTagArticle(let tagArray, _):
            self = .followedTagArticle(tagArray, page)
        case .stockArticle(let userID, _):
            self = .stockArticle(userID, page)
        case .searchWord(let searchWord, _):
            self = .searchWord(searchWord, page)
        case .userPostedArticle(let userID, _):
            self = .userPostedArticle(userID, page)
        default:
            break
        }
    }
}

extension QiitaAPI: TargetType {
    
    var baseURL: URL {
        // TODO: OptionalBindingの方法が分からない。nilで帰ってきたらどうするか？
        return URL(string:"https://qiita.com")!
    }
    
    // TODO: ページングするため、叩くAPIは指定するページを更新出来るようにする
    var path: String {
        switch self {
        case .newArticle, .followedTagArticle, .searchWord, .searchTag, .userPostedArticle:
            return "/api/v2/items"
        case .stockArticle:
            return "/api/v2/users/\(Defaults.userID)/stocks"
        case .authenticatedUser:
            return "/api/v2/authenticated_user"
        case .userProfile(let userID):
            return "/api/v2/users/\(userID)"
        case .followedTag(let userID):
            return "api/v2/users/\(userID)/following_tags"
        case .followUsers(let userID):
            return "/api/v2/users/\(userID)/followees"
        case .followerUsers(let userID):
            return "/api/v2/users/\(userID)/followers"
        case .browsingHistory:
            return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .newArticle, .followedTagArticle, .stockArticle, .searchTag, .searchWord, .authenticatedUser, .userProfile, .followedTag, .userPostedArticle, .followUsers, .followerUsers , .browsingHistory:
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
        case .followedTagArticle(let followedTagArray, let page):
            let joinedTagArray = followedTagArray.joined(separator:  " OR tag:")
            paramerter = ["query": "tag:\(joinedTagArray)"]
            paramerter.updateValue(page, forKey: "page")
        case .searchWord(let searchWord, let page):
            paramerter = ["query": searchWord]
            paramerter.updateValue(page, forKey: "page")
        case .searchTag(let tagWord):
            paramerter = ["query": "tag:\(tagWord)"]
        case .userPostedArticle(let userID, let page):
            paramerter = ["query": "user:\(userID)"]
            paramerter.updateValue(page, forKey: "page")
        case .newArticle(let page):
            paramerter = ["page": page]
        case .stockArticle(_, let page):
            paramerter = ["page": page]
        case .browsingHistory, .authenticatedUser, .userProfile, .followedTag, .followUsers, .followerUsers:
            break
        }
        
        return .requestParameters(parameters: paramerter, encoding: URLEncoding.default)
    }

    var headers: [String : String]? {
        var paramerter: [String: String] = [:]
        
        switch self {
        case .newArticle, .searchWord, .searchTag, .followedTag, .userPostedArticle, .userProfile, .browsingHistory:
            break
        case .followedTagArticle, .stockArticle, .authenticatedUser, .followUsers, .followerUsers:
            paramerter = ["Authorization":"Bearer \(Defaults.token)"]
        }
        return  paramerter
    }
}
