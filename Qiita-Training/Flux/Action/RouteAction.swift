//
//  RouteAction.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

final class RouteAction {
    static let shared = RouteAction()
    
    private let dispatcher: AnyObserverDispatcher<RouteDispatcher>
    
    init(dispatcher: AnyObserverDispatcher<RouteDispatcher> = .init(.shared)) {
        self.dispatcher = dispatcher
    }
    
    func show(routeType: RouteType) {
        dispatcher.route.onNext(routeType)
    }
}
