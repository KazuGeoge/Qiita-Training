//
//  ProfileDetailViewModel.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import RxSwift

final class ProfileDetailViewModel {

    private let apiClient: APIClient
    private let disposeBag = DisposeBag()
    
    private let reloadSubject = PublishSubject<()>()
    var reload: Observable<()> {
        return reloadSubject.asObservable()
    }
    
    var profileModel: [Codable] = []
    var profileType: ProfileType?
    
    init(apiClient: APIClient = .shared) {
        self.apiClient = apiClient
    }
    
    func generateNavigationTitle() -> String {
        
        var title = "\(Defaults.userID)さんの"
        
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
            qiitaAPI = .followUsers
        case .follower:
            qiitaAPI = .followerUsers
        case .stock:
            qiitaAPI = .stockArticle
        case .tag:
            qiitaAPI = .followedTag
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
                    self?.reloadSubject.onNext(())
                } catch(let error) {
                    // TODO: エラーイベントを流す
                    print(error)
                }
            })
            .disposed(by: self.disposeBag)
    }
}
