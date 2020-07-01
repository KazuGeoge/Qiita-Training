//
//  ArticleTableViewCell.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/07/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var articleTitleLabel: UILabel!
    @IBOutlet private weak var favCountView: UIView!
    @IBOutlet private weak var favCountLabel: UILabel!
    @IBOutlet private weak var tagsView: UIView!
    @IBOutlet private weak var tagsLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    
}
