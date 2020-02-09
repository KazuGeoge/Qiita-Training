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
    private let dataSouce = ProfileTableViewDataSouce()
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var followerButton: UIButton!
    @IBOutlet weak var stockButton: UIButton!
    @IBOutlet weak var tagButton: UIButton!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSouce.configure(tableView: tableView)
        configureButton()
    }
    
    
    func configureButton() {
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
