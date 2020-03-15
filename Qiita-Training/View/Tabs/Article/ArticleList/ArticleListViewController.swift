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
    var qiitaAPIType: QiitaAPI?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSouce.configure(tableView: tableView)
        observeArticleStore()
    }
    
    private func observeArticleStore() {
        ArticleStore.shared.articleStream.asObservable()
            .observeOn(MainScheduler.instance)
            .filter { [weak self] in $0.1 == self?.qiitaAPIType }
            .subscribe(onNext: { [weak self] articleStream in
                self?.dataSouce.articleList = articleStream.0
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}
