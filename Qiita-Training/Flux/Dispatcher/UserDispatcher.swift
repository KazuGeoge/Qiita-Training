//
//  UserDispatcher.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/06/10.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import RxSwift
import RxCocoa

// データフローを単一方向に保つ
final class UserDispatcher: DispatcherType {
       static let shared = UserDispatcher()
        
        fileprivate let user = PublishSubject<(User)>()
        
        private init() {}
}

// onNextだけができるDispathcher
extension AnyObserverDispatcher where Dispatcher: UserDispatcher {
    var user: AnyObserver<(User)> {
        return dispatcher.user.asObserver()
    }
}

// subscribeだけができるDispatcher
extension AnyObservableDispatcher where Dispatcher: UserDispatcher {
    var user: Observable<(User)> {
        return dispatcher.user
    }
}
