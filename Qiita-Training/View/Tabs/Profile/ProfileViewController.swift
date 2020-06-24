//
//  ProfileViewController.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {

    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var userName: UILabel!
    @IBOutlet private weak var smallUserName: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    private lazy var viewModel = ProfileViewModel()
    private lazy var dataSouce = ProfileTableViewDataSouce(viewModel: viewModel)
    @IBOutlet private weak var followButton: UIButton!
    @IBOutlet private weak var followerButton: UIButton!
    @IBOutlet private weak var stockButton: UIButton!
    @IBOutlet private weak var tagButton: UIButton!
    @IBOutlet private weak var followCountLabel: UILabel!
    @IBOutlet private weak var followerCountLabel: UILabel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getUserPostedArticle()
        observeViewModel()
        dataSouce.configure(tableView: tableView)
        configureButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        configureUI()
    }
    
    private func observeViewModel() {
        viewModel.reload.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func configureUI() {
        let user = viewModel.getUserStoreValue()
        
        userName.text = user?.id
        
        // TODO: 画像処理は別Issueで行う
        if let follow = user?.followsCount, let followers = user?.followersCount {
            followCountLabel.text = String(follow)
            followerCountLabel.text = String(followers)
        }
    }

    private func configureButton() {
        followButton.rx.tap
            .subscribe({ _ in
                RouteAction.shared.show(routeType: .profileDetail(.follow))
            })
            .disposed(by: disposeBag)
        
        followerButton.rx.tap
            .subscribe({ _ in
                RouteAction.shared.show(routeType: .profileDetail(.follower))
            })
            .disposed(by: disposeBag)
        
        stockButton.rx.tap
            .subscribe({ _ in
                RouteAction.shared.show(routeType: .profileDetail(.stock))
            })
            .disposed(by: disposeBag)
        
        tagButton.rx.tap
            .subscribe({ _ in
                RouteAction.shared.show(routeType: .profileDetail(.tag))
            })
            .disposed(by: disposeBag)
    }
}
