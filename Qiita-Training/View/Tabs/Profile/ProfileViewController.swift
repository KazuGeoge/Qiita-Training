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
import SwiftyUserDefaults

class ProfileViewController: UIViewController {

    lazy var viewModel = ProfileViewModel()
    private lazy var dataSouce = ProfileTableViewDataSouce(viewModel: viewModel)
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var userName: UILabel!
    @IBOutlet private weak var smallUserName: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var followButton: UIButton!
    @IBOutlet private weak var followerButton: UIButton!
    @IBOutlet private weak var stockButton: UIButton!
    @IBOutlet private weak var tagButton: UIButton!
    @IBOutlet private weak var followCountLabel: UILabel!
    @IBOutlet private weak var followerCountLabel: UILabel!
    @IBOutlet private weak var isFollowButton: IsFollowButton!
    @IBOutlet private weak var isFollowButtonTop: NSLayoutConstraint!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        observeViewModel()
        dataSouce.configure(tableView: tableView)
        configureButton()
        configureNavigationBar()
        setUserData()
        
        if !viewModel.isSelfUser {
            isFollowButton.isHidden = false
            isFollowButtonTop.priority = UILayoutPriority(rawValue: 1000)
            
            viewModel.isFollowUser()
        }
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .green
        navigationItem.configure(navigationItemType: .profile, disposeBag: disposeBag, title: "プロフィール")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        configureUI()
    }
    
    // ユーザーのIDを元にAPIを叩くためsetUserIDを必ず最初に呼ぶ
    private func setUserData() {
        viewModel.setUserID()
        viewModel.getUserDate()
    }
    
    private func observeViewModel() {
        viewModel.reload.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
                self?.configureUI()
            })
            .disposed(by: disposeBag)
        
        viewModel.follow.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.isFollowButton.configureFollowState()
            })
            .disposed(by: disposeBag)
    }
    
    private func configureUI() {
        let user = viewModel.user
        
        if let userProfileImageString = user?.profileImageUrl {
            userImageView.kf.setImage(with: URL(string: userProfileImageString))
        }
        
        userName.text = user?.id
        smallUserName.text = user?.id
        
        // TODO: 画像処理は別Issueで行う
        if let follow = user?.followeesCount, let followers = user?.followersCount {
            followCountLabel.text = String(follow)
            followerCountLabel.text = String(followers)
        }
    }

    private func configureButton() {
        followButton.rx.tap
            .subscribe({ [weak self] _ in
                self?.viewModel.showProfileDetail(profileType: .follow)
            })
            .disposed(by: disposeBag)
        
        followerButton.rx.tap
            .subscribe({ [weak self] _ in
                self?.viewModel.showProfileDetail(profileType: .follower)
            })
            .disposed(by: disposeBag)
        
        stockButton.rx.tap
            .subscribe({ [weak self] _ in
                self?.viewModel.showProfileDetail(profileType: .stock)
            })
            .disposed(by: disposeBag)
        
        tagButton.rx.tap
            .subscribe({ [weak self] _ in
                self?.viewModel.showProfileDetail(profileType: .tag)
            })
            .disposed(by: disposeBag)
    }
}
