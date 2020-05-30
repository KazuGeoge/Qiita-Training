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
    var isLoginUdser: DefaultsKey<Bool> { return .init("isLoginUdser", defaultValue: false) }
    var token: DefaultsKey<String> { return .init("token", defaultValue: "") }
    var searchedTagArray: DefaultsKey<[String]> { return .init("searchedTagArray", defaultValue: []) }
    var followedTagArray: DefaultsKey<[String]> { return .init("followedTagArray", defaultValue: []) }
    var searchedArray: DefaultsKey<[String]> { return .init("searchedArray", defaultValue: []) }
    var userID: DefaultsKey<String> { return .init("userID", defaultValue: "") }
}
