//
//  AuthenticationViewModel.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/05/17.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import RxSwift
import RxCocoa

class AuthenticationViewModel: NSObject {

    private let loginAction: LoginAction
    private let apiClient: APIClient
    private let userAction: UserAction
    private let disposeBag = DisposeBag()
    
    init(loginAction: LoginAction = .shared, apiClient: APIClient = .shared, userAction: UserAction = .shared) {
        self.apiClient = apiClient
        self.loginAction = loginAction
        self.userAction = userAction
    }
    
    func getUserData(token: String = "298bfa9c40f01d3bcea2d5a39d04a578d4d4c312",
                     fetchComplete:@escaping () -> ()) {
        
        // Tokenを取得したら保存して認証画面を閉じる。
        Defaults.token = token
        Defaults.isLoginUdser = true
        
        apiClient.provider.rx.request(.authenticatedUser)
            .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { [weak self] articleListResponse in
                do {
                    let result = try User.decode(json: articleListResponse.data)
                    // UserActionで受け取ったユーザー情報を流す
                    self?.userAction.user(user: result)
                    fetchComplete()
                    self?.getFollowedTagData()
                } catch(let error) {
                    // TODO: エラーイベントを流す
                    print(error)
                }
            }) { (error) in
                // TODO: エラーイベントを流す
                print(error)
        }
        .disposed(by: self.disposeBag)
    }
    
    private func getFollowedTagData() {
        apiClient.provider.rx.request(.followedTag)
                   .filterSuccessfulStatusCodes()
                   .subscribe(onSuccess: { [weak self] followedTagResponse in
                       do {
                        let result = try [FollowedTag].decode(json: followedTagResponse.data)
                        Defaults.followedTagArray = result.map {$0.id}
                        self?.loginAction.login()
                       } catch(let error) {
                           // TODO: エラーイベントを流す
                           print(error)
                       }
                   }) { (error) in
                       // TODO: エラーイベントを流す
                       print(error)
               }
               .disposed(by: self.disposeBag)
    }
}
