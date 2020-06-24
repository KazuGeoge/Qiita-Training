//
//  ProfileDetailViewModel.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

final class ProfileDetailViewModel {

    var profileType: ProfileType?
    
    func generateNavigationTitle() -> String {
        
        var title = "\(Defaults.userID)さんの"
        
        switch profileType {
        case .follow:
            title.append("フォロー")
        case .follower:
            title.append("フォロワー")
        case .stock:
            title.append("ストックした投稿")
        case .tag:
            title.append("フォロー中タグ")
        case .none:
            break
        }
        return title
    }
}
