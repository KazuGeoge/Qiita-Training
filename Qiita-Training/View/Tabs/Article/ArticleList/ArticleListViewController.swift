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
    private let disposeBag = DisposeBag()
    var qiitaAPIType: QiitaAPI?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSouce.configure(tableView: tableView)
        observeViewModel()
        viewModel.qiitaAPIType = qiitaAPIType
        viewModel.setIsSearchTag()
        observeTableViewDidScroll()
    }
    
    private func observeViewModel() {
        viewModel.reload.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func observeTableViewDidScroll() {
        tableView.rx.didScroll.asObservable()
            .withLatestFrom(tableView.rx.contentOffset.asObservable())
            .map { $0.y }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] currentOffsetY in
                self?.tableViewDidScroll(currentOffsetY: currentOffsetY)
            })
            .disposed(by: disposeBag)
    }
    
    private func tableViewDidScroll(currentOffsetY: CGFloat) {
        // 次の読み込みをページの底辺からの位置で判断し無限スクロールにする
        let maximumOffset = tableView.contentSize.height - tableView.frame.height
        let distanceToBottom = maximumOffset - currentOffsetY
        
        // 底から600の距離に来たら更新用の読み込みをする。ロード中にはAPIを叩かないようにする。
        if distanceToBottom <= 500 && !viewModel.isLoding && !viewModel.isEmptyContentList {
            viewModel.isLoding = true
            viewModel.callAPI()
        }
    }
}
