//
//  Article.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/03/15.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit

struct Article: Codable {
    var title: String
    var url: String
    var id: String
    var tags: [Tag]
    var createdAt: String
    var user: User

    enum CodingKeys: String, CodingKey {
        case title
        case url
        case id
        case tags
        case createdAt = "created_at"
        case user
    }
    
    struct Tag: Codable {
        var name: String
    }
    
    struct User: Codable {
        var profileImageURL: String
        
        enum CodingKeys: String, CodingKey {
            case profileImageURL = "profile_image_url"
        }
    }
}
