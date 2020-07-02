//
//  ArticleTableViewCell.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/07/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var articleTitleLabel: UILabel!
    @IBOutlet private weak var favCountView: UIView!
    @IBOutlet private weak var favCountLabel: UILabel!
    @IBOutlet private weak var tagsView: UIView!
    @IBOutlet private weak var tagsLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    
    func configure(article: Article) {
        
        if article.likesCount == 0 {
            favCountView.isHidden = true
            tagsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        }
        
        favCountLabel.text = String(article.likesCount)
        iconImageView.kf.setImage(with: URL(string: article.user.profileImageUrl))
        userNameLabel.text = article.id
        articleTitleLabel.text = article.title
        tagsLabel.text = article.tags.map { $0.name }.joined(separator: " ")
        timeLabel.text = article.createdAtDate?.offsetFrom()
    }
}
