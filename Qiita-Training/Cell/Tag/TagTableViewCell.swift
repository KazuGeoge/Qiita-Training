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
    @IBOutlet weak var isFollowButton: UIButton!
    @IBOutlet weak var isFollowButtonTop: NSLayoutConstraint!
    
    override func prepareForReuse() {
        // UIImageViewのbackGroundColorは表示させたいためisHiddenにはしない
        tagIconImageView.image = UIImage()
    }
    
    func configure(followedTag: FollowedTag) {
        tagNameLabel.text = followedTag.id
        postedNumLabel.text = String(followedTag.itemsCount) + "件の投稿"
        followerNumLabel.text = String(followedTag.followersCount) + "人のフォロワー"
        
        if let iconUrlString = followedTag.iconUrl {
            tagIconImageView.kf.setImage(with: URL(string: iconUrlString))
        }
    }
}
