//
//  LoginDispatcher.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/03/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import RxSwift
import RxCocoa

// データフローを単一方向に保つ
final class LoginDispatcher: DispatcherType {
       static let shared = LoginDispatcher()
        
        fileprivate let login = PublishSubject<()>()
        
        private init() {}
}

// onNextだけができるDispathcher
extension AnyObserverDispatcher where Dispatcher: LoginDispatcher {
    var login: AnyObserver<()> {
        return dispatcher.login.asObserver()
    }
}

// subscribeだけができるDispatcher
extension AnyObservableDispatcher where Dispatcher: LoginDispatcher {
    var login: Observable<()> {
        return dispatcher.login
    }
}
