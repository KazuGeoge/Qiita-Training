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
    let loginStream: Observable<()>
    
    init() {
        display = RouteStore.shared.routeStream.asObservable()
        loginStream = LoginStore.shared.loginStream.asObservable()
    }
}
