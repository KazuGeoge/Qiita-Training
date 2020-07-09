//
//  TagTableViewCell.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/07/09.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit

class TagTableViewCell: UITableViewCell {
    @IBOutlet private weak var tagIconImageView: UIImageView!
    @IBOutlet private weak var tagNameLabel: UILabel!
    @IBOutlet private weak var postedNumLabel: UILabel!
    @IBOutlet private weak var followerNumLabel: UILabel!
}
