//
//  LoginStore.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/03/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import RxSwift
import RxCocoa

final class LoginStore {
    static let shared = LoginStore()
    var login: Observable<()>
    
    init(dispatcher: AnyObservableDispatcher<LoginDispatcher> = .init(.shared)) {
        
        login = dispatcher.login
    }
}

