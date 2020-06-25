//
//  SettingViewController.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit
import RxSwift

class SettingViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private lazy var viewModel = SettingViewModel()
    private lazy var datasouce = SettingTableViewDataSouce(viewModel: viewModel)
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datasouce.configure(tableView: tableView)
        
        navigationController?.navigationBar.barTintColor = .green
        navigationItem.configure(navigationItemType: .setting, disposeBag: disposeBag, title: "設定")
    }
}
