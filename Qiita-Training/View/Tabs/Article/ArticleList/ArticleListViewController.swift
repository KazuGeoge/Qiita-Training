//
//  ArticleListViewController.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit

class ArticleListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private let dataSouce = ArticleListTableViewDataSouce()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSouce.configure(tableView: tableView)
    }
}
