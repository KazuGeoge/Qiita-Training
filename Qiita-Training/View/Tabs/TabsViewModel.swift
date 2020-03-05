//
//  TabsViewModel.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//
import RxSwift
import RxCocoa

final class TabsViewModel {
    let display: Observable<RouteType?>
    let login: Observable<()>
    private let routeStore: RouteStore
    private let loginStore: LoginStore
    
    init(routeStore: RouteStore = .shared, loginStore: LoginStore = .shared) {
        display = RouteStore.shared.routeStream.asObservable()
        login = LoginStore.shared.loginStream.asObservable()
        self.routeStore = routeStore
        self.loginStore = loginStore
    }
}
