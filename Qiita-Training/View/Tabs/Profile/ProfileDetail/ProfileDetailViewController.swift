//
//  ProfileDetailViewController.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum ProfileType {
    case follow
    case follower
    case stock
    case tag
}

class ProfileDetailViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    lazy var viewModel = ProfileDetailViewModel()
    private lazy var dataSouce = ProfileDetailTableViewDataSouce(viewModel: self.viewModel)
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSouce.configure(tableView: tableView)
        navigationItem.configure(navigationItemType: .profileDetail, disposeBag: disposeBag, title: viewModel.generateNavigationTitle())        
    }
}
