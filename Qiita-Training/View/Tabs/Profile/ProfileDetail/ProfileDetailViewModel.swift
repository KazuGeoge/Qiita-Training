//
//  ProfileDetailViewModel.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ProfileDetailViewModel: NSObject {

    private let apiClient: APIClient
    private let disposeBag = DisposeBag()
    private let routeAction: RouteAction
    private let viewWillAppear: Observable<(Void)>
    
    private let reloadRelay = PublishRelay<()>()
    var reload: Observable<()> {
        return reloadRelay.asObservable()
    }
    
    var profileModel: [Codable] = []
    var profileType: ProfileType?
    var userID = ""
    
    init(apiClient: APIClient = .shared, routeAction: RouteAction = .shared, viewWillAppear: Observable<Void>) {
        self.apiClient = apiClient
        self.routeAction = routeAction
        self.viewWillAppear = viewWillAppear
        super.init()
                
        viewWillAppear
            .subscribe(onNext: { [weak self] _ in
                self?.getProfileData()
            })
            .disposed(by: disposeBag)
    }
    
    func generateNavigationTitle() -> String {
        
        var title = "\(userID)さんの"
        
        switch profileType {
        case .follow:
            title.append(profileType?.text ?? "")
        case .follower:
            title.append(profileType?.text ?? "")
        case .stock:
            title.append(profileType?.text ?? "")
        case .tag:
            title.append(profileType?.text ?? "")
        case .none:
            break
        }
        return title
    }
    
    func getProfileData() {
        var qiitaAPI: QiitaAPI?
        
        switch profileType {
        case .follow:
            qiitaAPI = .followUsers(userID)
        case .follower:
            qiitaAPI = .followerUsers(userID)
        case .stock:
            qiitaAPI = .stockArticle(userID)
        case .tag:
            qiitaAPI = .followedTag(userID)
        case .none:
            break 
        }
        
        callAPI(qiitaAPI: qiitaAPI)
    }
    
    private func callAPI(qiitaAPI: QiitaAPI?) {
        
        guard let qiitaAPI = qiitaAPI else { return }
        apiClient.provider.rx.request(qiitaAPI)
            .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { [weak self] response in
                do {
                    switch self?.profileType {
                    case .follow, .follower:
                        self?.profileModel = try [User].decode(json: response.data)
                    case .stock:
                        self?.profileModel = try [Article].decode(json: response.data)
                    case .tag:
                        self?.profileModel = try [FollowedTag].decode(json: response.data)
                    case .none:
                        break
                    }
                    self?.reloadRelay.accept(())
                } catch(let error) {
                    // TODO: エラーイベントを流す
                    print(error)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    func showRouteAction(codableModel: Codable) {
        // TODO: プロフィールの遷移も引数のmodelを使って処理する
        switch profileType {
        case .follow, .follower:
            if let user = codableModel as? User {
                routeAction.show(routeType: .profile(false, user.id))
            }
        case .stock:
            if let article = codableModel as? Article {
                routeAction.show(routeType: .articleDetail(article))
            }
        case .tag:
            if let article = codableModel as? Article {
                routeAction.show(routeType: .articleDetail(article))
            }
        default:
            break
        }
    }
}
