//
//  QiitaAPITargetType.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/03/15.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import Moya
import Foundation

enum QiitaAPI {
    case newArticle
    case followArticle
    case stockArticle
}

extension QiitaAPI: TargetType {
    
    var baseURL: URL {
        // TODO: OptionalBindingの方法が分からない。nilで帰ってきたらどうするか？
        return URL(string:"https://qiita.com")!
    }
    
    var path: String {
        switch self {
        case .newArticle:
            return "/api/v2/items"
        case .followArticle:
            return ""
        case .stockArticle:
            return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .newArticle, .followArticle, .stockArticle:
            return .get
        }
    }

    //テストの際テスト用のjsonを返すことができるメソッド
    var sampleData: Data {
        return Data()
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String : String]? {
        return nil
    }
}
