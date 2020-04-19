//
//  LoginAction.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/03/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit

final class LoginAction {
    static let shared = LoginAction()
    private let dispatcher: AnyObserverDispatcher<LoginDispatcher>
    
    init(dispatcher: AnyObserverDispatcher<LoginDispatcher> = .init(.shared)) {
        self.dispatcher = dispatcher
    }
    
    func login() {
        dispatcher.login.onNext(())
    }
}
