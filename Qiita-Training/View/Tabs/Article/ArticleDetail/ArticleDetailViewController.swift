//
//  ArticleViewController.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa

class ArticleDetailViewController: UIViewController, WKUIDelegate {

    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var tagCollectionView: UICollectionView!
    @IBOutlet private weak var tagCollectionViewHeight: NSLayoutConstraint!
    private var dataSouce: TagCollectionViewDataSouce?
    private let disposeBag = DisposeBag()
    private let viewModel = ArticleDetailViewModel()
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeViewModel()
        configureUI()
        configureDataSouce()
        openWeb()
    }

    private func configureUI() {
        titleLabel.text = article?.title
        userNameLabel.text = article?.user.id
        timeLabel.text = article?.createdAt
    }
    
    private func configureDataSouce() {
        dataSouce = TagCollectionViewDataSouce(tagCollectionView: tagCollectionView)
        dataSouce?.configure(tagArray: article?.tags.map { $0.name } ?? [])
    }
    
    // HACK: 壁画前にCollectionViewのheightを決定出来る方法
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        dataSouce?.tagAllWidth = 10
        tagCollectionView.reloadData()
    }
    
    private func observeViewModel() {
        viewModel.heightStream.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] height in
                self?.tagCollectionViewHeight.constant = height
            })
            .disposed(by: disposeBag)
    }
    
    func openWeb() {
        webView.uiDelegate = self
        loadURL(urlString: article?.url ?? "")
    }
    
    func loadURL(urlString: String) {
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
    }
}
