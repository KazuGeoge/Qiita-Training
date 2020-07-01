//
//  TagCollectionViewCell.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/04/02.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var tagLabel: UILabel!
    
    func configure(tagText: String) {
        tagLabel.text = tagText
    }
}
