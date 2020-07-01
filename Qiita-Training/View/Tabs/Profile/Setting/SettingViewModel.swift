//
//  SettingViewModel.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//
import UIKit
import SwiftyUserDefaults

final class SettingViewModel {
    
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
        
      // それぞれのURLも実装する
    }
    
    var typeList: [[SettingType]] {
        return
            [
                [.switchTeam, .browsedHistory, Defaults.isLoginUdser ? .logOut: .logIn],
                [.feedBack, .license]
        ]
    }
}
