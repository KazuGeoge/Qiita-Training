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
    private let disposeBag = DisposeBag()
    
    init(loginAction: LoginAction = .shared, apiClient: APIClient = .shared) {
        self.apiClient = apiClient
        self.loginAction = loginAction
    }
    
    // TODO: tokenは取得したtokenを使用。
    func getUser(token: String = "cfd0c856460f4aa1cfa5d473a312091b5f86d2ed") {
        // Tokenを取得したら保存して認証画面を閉じる。
        Defaults.token = token
        Defaults.isLoginUdser = true
        
        getUserAPI()
    }
    
    func getUserAPI() {
        apiClient.provider.rx.request(.authenticatedUser)
            .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { [weak self] articleListResponse in
                do {
                    let result = try User.decode(json: articleListResponse.data)
                    // UserActionで受け取ったユーザー情報を流す
                    Defaults.userID = result.id
                    self?.getFollowedTagAPI()
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
    
    func getFollowedTagAPI() {
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
