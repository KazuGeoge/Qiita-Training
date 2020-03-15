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
    private let dataSouce = ArticleListTableViewDataSouce()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSouce.configure(tableView: tableView)
        observeArticleStore()
    }
    
    private func observeArticleStore() {
        ArticleStore.shared.articleStream.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] articleList in
                self?.dataSouce.articleList = articleList
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}
