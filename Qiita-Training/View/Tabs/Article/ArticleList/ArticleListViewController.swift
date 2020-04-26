//
//  ArticleListViewController.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ArticleListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private lazy var viewModel = ArticleListViewModel()
    private lazy var dataSouce = ArticleListTableViewDataSouce(viewModel: viewModel)
    var qiitaAPIType: QiitaAPI?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSouce.configure(tableView: tableView)
        viewModel.observeArticleStore(qiitaAPIType: qiitaAPIType)
    }
}
