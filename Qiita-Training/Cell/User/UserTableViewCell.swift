//
//  UserTableViewCell.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/07/08.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    func configure(user: User) {
        iconImageView.kf.setImage(with: URL(string: user.profileImageUrl))
        userNameLabel.text = user.id
        descriptionLabel.text = user.description
    }
}
