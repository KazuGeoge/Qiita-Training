//
//  NameDescribable.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/07/17.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit

protocol NameDescribable {
}

extension NameDescribable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

// NSObjectに準拠させて各Classで使えるようにする
extension NSObject: NameDescribable { }
