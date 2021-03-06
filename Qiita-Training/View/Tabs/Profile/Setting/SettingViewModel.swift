//
//  SettingViewModel.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//
import UIKit
import SwiftyUserDefaults
import RealmSwift

final class SettingViewModel {
    
    private let routeAction: RouteAction
    private let apiClient: APIClient
    private let articleAction: ArticleAction
    private var articleList: [Article] = []
    
    init(routeAction: RouteAction = .shared, apiClient: APIClient = .shared, articleAction: ArticleAction = .shared) {
        self.routeAction = routeAction
        self.apiClient = apiClient
        self.articleAction = articleAction
    }
    
    enum SettingType {
        case switchTeam, browsedHistory, logIn, logOut, feedBack, license
        
        var text: String {
            switch self {
            case .switchTeam:     return "チームの切り替え"
            case .browsedHistory: return "投稿の履歴閲覧"
            case .logIn:          return "ログイン"
            case .logOut:         return "ログアウト"
            case .feedBack:       return "フィードバックを送信"
            case .license:        return "ライセンス"
            }
        }
    }
    
    var typeList: [[SettingType]] {
        return
            [
                [.switchTeam, .browsedHistory, Defaults.isLoginUdser ? .logOut: .logIn],
                [.feedBack, .license]
        ]
    }
    
    func selectCell(settingType: SettingType) {
        switch settingType {
        case .browsedHistory:
            getArticle()
        default:
            break
        }
    }
    
    func getArticle() {
        let realm = try? Realm()
        guard let resultArticleObjectArray = realm?.objects(ArticleRealmObject.self) else { return }
        
        var articleList: [Article] = resultArticleObjectArray.compactMap { $0.article }
        //　閲覧履歴が下に追加されていくのは不自然なため配列の順番を変える
        articleList.reverse()
        routeAction.show(routeType: .articleList(.browsingHistory))
        
        // ArticleListに遷移して監視articleStoreの監視があってからイベントを流すため遅延させる
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.articleAction.article(articleList: articleList, qiitaAPIType: .browsingHistory)
        }
    }
}
