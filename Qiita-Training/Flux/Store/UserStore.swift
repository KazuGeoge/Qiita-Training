//
//  UserStore.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/06/10.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import RxSwift
import RxCocoa

final class UserStore {
    static let shared = UserStore()
    private let disposeBag = DisposeBag()
    
    let user = BehaviorRelay<User?>(value: nil)
    
    init(dispatcher: AnyObservableDispatcher<UserDispatcher> = .init(.shared)) {
        dispatcher.user
            .bind(to: user)
            .disposed(by: disposeBag)
    }
}
