//
//  RouteDispatcher.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import RxSwift
import RxCocoa
// データフローを単一方向に保つ
final class RouteDispatcher: DispatcherType {
    static let shared = RouteDispatcher()
    
    fileprivate let route = PublishSubject<RouteType>()
    
    private init() {}
}
// onNextだけができるDispathcher
extension AnyObserverDispatcher where Dispatcher: RouteDispatcher {
    var route: AnyObserver<RouteType> {
        return dispatcher.route.asObserver()
    }
}

// subscribeだけができるDispatcher
extension AnyObservableDispatcher where Dispatcher: RouteDispatcher {
    var route: Observable<RouteType> {
        return dispatcher.route
    }
}
