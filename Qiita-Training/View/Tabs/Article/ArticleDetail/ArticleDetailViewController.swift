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
    private lazy var dataSouce = TagCollectionViewDataSouce(tagCollectionView: tagCollectionView)
    private let disposeBag = DisposeBag()
    private let viewModel = ArticleDetailViewModel()
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDataSouce()
        openWeb()
    }

    private func configureUI() {
        titleLabel.text = article?.title
        userNameLabel.text = article?.user.id
        timeLabel.text = article?.createdAt
        
        tabBarController?.tabBar.isHidden = true
    }
    
    private func configureDataSouce() {
        dataSouce.configure(tagArray: article?.tags.map { $0.name } ?? [])
    }
    
    override func viewDidLayoutSubviews() {
        
        self.tagCollectionView.reloadData()
        self.tagCollectionView.performBatchUpdates(nil, completion: { [weak self] _ in
            self?.tagCollectionViewHeight.constant = (self?.tagCollectionView.collectionViewLayout.collectionViewContentSize.height ?? 0) + 10
        })
    }
    
    private func openWeb() {
        webView.uiDelegate = self
        webView.scrollView.isScrollEnabled = false
        loadURL(urlString: article?.url ?? "")
    }
    
    private func loadURL(urlString: String) {
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
    }
}
