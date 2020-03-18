//
//  UserDefaults.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/03/12.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

extension DefaultsKeys {
    var isLoginUdser: DefaultsKey<Bool> { return .init("isLoginUser", defaultValue: false) }
    var token: DefaultsKey<String?> { return .init("token") }
}
