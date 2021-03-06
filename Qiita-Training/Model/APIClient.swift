//
//  APIClient.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/03/15.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import Moya

class APIClient: NSObject {
    
    static let shared = APIClient()
    let provider = MoyaProvider<QiitaAPI>()
}
