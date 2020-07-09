//
//  TagTableViewCell.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/07/09.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit
import Kingfisher

class TagTableViewCell: UITableViewCell {
    @IBOutlet private weak var tagIconImageView: UIImageView!
    @IBOutlet private weak var tagNameLabel: UILabel!
    @IBOutlet private weak var postedNumLabel: UILabel!
    @IBOutlet private weak var followerNumLabel: UILabel!
    
    func configure(followedTag: FollowedTag) {
        tagIconImageView.kf.setImage(with: URL(string: followedTag.iconUrl))
        tagNameLabel.text = followedTag.id
        postedNumLabel.text = String(followedTag.itemsCount)
        followerNumLabel.text = String(followedTag.followersCount)
    }
}
