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
    var likesCount: Int
    var createdAtDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"
        
        return dateFormatter.date(from: self.createdAt)
    }
    
    struct Tag: Codable {
        var name: String
    }
}
