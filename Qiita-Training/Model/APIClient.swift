//
//  APIClient.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/03/15.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit
import RxSwift
import RxMoya
import Moya

class APIClient: NSObject {

    static let shared = APIClient()
    private let disposeBag = DisposeBag()

    func call<T: Codable>(qiitaAPI: QiitaAPI) -> Observable<T> {
        return Observable.create { observer in
            
            let provider = MoyaProvider<QiitaAPI>()
            provider.rx.request(qiitaAPI)
                .filterSuccessfulStatusCodes()
                .map(T.self)
                .subscribe(onSuccess: { profile in
                    observer.onNext(profile)
                }) { (error) in
                    // TODO: エラーイベントを流す
                    print(error)
            }
            .disposed(by: self.disposeBag)


            return Disposables.create()
        }
    }
}
