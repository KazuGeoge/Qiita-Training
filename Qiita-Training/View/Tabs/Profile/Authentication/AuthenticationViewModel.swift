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
    func getUser(token: String = "298bfa9c40f01d3bcea2d5a39d04a578d4d4c312") {
        // Tokenを取得したら保存して認証画面を閉じる。
        Defaults.token = token
        Defaults.isLoginUdser = true
        
        getUserData()
    }
    
    func getUserData() {
        apiClient.provider.rx.request(.authenticatedUser)
            .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { [weak self] articleListResponse in
                do {
                    let result = try User.decode(json: articleListResponse.data)
                    // UserActionで受け取ったユーザー情報を流す
                    Defaults.userID = result.id
                    self?.getFollowedTagData()
                    self?.getUserPostedArticle()
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
    
    private func getUserPostedArticle() {
        apiClient.provider.rx.request(.userPostedArticle)
            .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { articleAraayResponse in
                do {
                    let article = try [Article].decode(json: articleAraayResponse.data)
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
