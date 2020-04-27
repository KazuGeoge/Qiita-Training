//
//  Array.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/04/27.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import Foundation

extension Array {
    func unique() -> [Self.Element] {
        return NSOrderedSet(array: self).array as! [Self.Element]
    }
}
