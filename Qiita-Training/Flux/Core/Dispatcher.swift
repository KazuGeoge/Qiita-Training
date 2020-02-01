//
//  Dispatcher.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

// データフローを単一方向に保つ
protocol DispatcherType {
    static var shared: Self { get }
}

// onNextだけができるDispathcher
final class AnyObserverDispatcher<Dispatcher: DispatcherType> {
    let dispatcher: Dispatcher
    init(_ dispatcher: Dispatcher = .shared) {
        self.dispatcher = dispatcher
    }
}

// subscribeだけができるDispatcher
final class AnyObservableDispatcher<Dispatcher: DispatcherType> {
    let dispatcher: Dispatcher
    init(_ dispatcher: Dispatcher = .shared) {
        self.dispatcher = dispatcher
    }
}
