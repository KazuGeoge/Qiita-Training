//
//  Tag.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/05/31.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit

struct FollowedTag: Codable {
    var id: String
    var followersCount: Int
    var iconUrl: String
    var itemsCount: Int
}
