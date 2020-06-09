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

    @IBOutlet private weak var tableView: UITableView!
    private lazy var viewModel = ProfileViewModel()
    private lazy var dataSouce = ProfileTableViewDataSouce(viewModel: viewModel)
    @IBOutlet private weak var followButton: UIButton!
    @IBOutlet private weak var followerButton: UIButton!
    @IBOutlet private weak var stockButton: UIButton!
    @IBOutlet private weak var tagButton: UIButton!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getUserPostedArticle()
        observeViewModel()
        dataSouce.configure(tableView: tableView)
        configureButton()
    }
    
    private func observeViewModel() {
        viewModel.reload.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
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
