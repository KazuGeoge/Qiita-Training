//
//  RouteStore.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import RxSwift
import RxCocoa

enum RouteType {
   case articleDetail(Article)
   case articleList(QiitaAPI)
   case profile
   case profileDetail(ProfileType)
   case login
   case stillLogin
   case setting
   case dismiss
}

final class RouteStore {
    static let shared = RouteStore()
    
    var route: Observable<RouteType?> {
        return routeState.asObservable()
    }

    let routeState = BehaviorRelay<RouteType?>(value: nil)
    private let disposeBag = DisposeBag()
    
    init(dispatcher: AnyObservableDispatcher<RouteDispatcher> = .init(.shared)) {
        
        dispatcher.route
            .bind(to: routeState)
            .disposed(by: disposeBag)
    }
}
