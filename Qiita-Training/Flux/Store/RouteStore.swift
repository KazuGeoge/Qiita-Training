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
   case article
   case articleDetaile
   case profile
   case profileDetail(ProfileType)
}

final class RouteStore {
    static let shared = RouteStore()
    
    var routeStream: Observable<RouteType?> {
        return routeState.asObservable()
    }

    let routeState = BehaviorRelay<RouteType?>(value: nil)
    private let disposeBag = DisposeBag()
    
    init(dispatcher: AnyObservableDispatcher<RouteDispatcher> = .init(.shared)) {
        
        dispatcher.routeStream
            .bind(to: routeState)
            .disposed(by: disposeBag)
    }
}
