//
//  ArticleListViewModel.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//
import Foundation
import UIKit

class ArticleListTableViewDataSouce: NSObject {
    
    private let viewModel: ArticleListViewModel
    
    init(viewModel: ArticleListViewModel) {
        self.viewModel = viewModel
    }
    
    func configure(tableView: UITableView) {
     
        tableView.register(UINib(nibName: ArticleTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ArticleTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: TagTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: TagTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
}

extension ArticleListTableViewDataSouce: UITableViewDelegate {
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        viewModel.showArticleDetail(article: viewModel.articleList[indexPath.row])
    }
}

extension ArticleListTableViewDataSouce: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        let indexPathRow = viewModel.isSearchTag ? indexPath.row - 1 : indexPath.row
        
        // タグを表示する時はヘッダーとしてタグのセルを一番最初に追加する
        if indexPath.row == 0, viewModel.isSearchTag,
            let tagTableViewCell = tableView.dequeueReusableCell(withIdentifier: TagTableViewCell.reuseIdentifier, for: indexPath) as? TagTableViewCell {
            tagTableViewCell.showFollowButton()
            
            return tagTableViewCell
        }
        
        if let articleTableViewCell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.reuseIdentifier, for: indexPath) as? ArticleTableViewCell {
            articleTableViewCell.configure(article: viewModel.articleList[indexPathRow])
            
            cell = articleTableViewCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0, viewModel.isSearchTag {
            return 120
        }
        
        tableView.estimatedRowHeight = 100

        return UITableView.automaticDimension
    }
}
