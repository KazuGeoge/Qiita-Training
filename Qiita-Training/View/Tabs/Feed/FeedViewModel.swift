//
//  FeedViewModel.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import RxSwift
import RxCocoa

final class FeedViewModel {
    let login: Observable<()>
    private let loginStore: LoginStore
    
    init(loginStore: LoginStore = .shared) {
        login = LoginStore.shared.loginStream.asObservable()
        self.loginStore = loginStore
    }
}
