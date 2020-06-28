//
//  UserAction.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/06/10.
//  Copyright © 2020 城島一輝. All rights reserved.
//
import SwiftyUserDefaults

final class UserAction {
    static let shared = UserAction()
    private let dispatcher: AnyObserverDispatcher<UserDispatcher>
    
    init(dispatcher: AnyObserverDispatcher<UserDispatcher> = .init(.shared)) {
        self.dispatcher = dispatcher
    }
    
    func user(user: User) {
        Defaults.userID = user.id
        dispatcher.user.onNext(user)
    }
}
