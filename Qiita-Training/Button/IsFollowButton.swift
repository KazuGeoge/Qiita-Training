//
//  FollowButton.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/07/24.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class IsFollowButton: UIButton {

    private var isFollow = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAttributes()
    }

    private func setupAttributes() {
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.5
        
        backgroundColor = .green
        setTitle("+ フォロー", for: .normal)
        setTitleColor(.white, for: .normal)
    }
    
    func configureFollowState() {
        isFollow = true
        backgroundColor = .white
        setTitle("✓ フォロー中", for: .normal)
        setTitleColor(.green, for: .normal)
    }
}
