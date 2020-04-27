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
     
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.articleList[indexPath.row].title
        
        return cell
    }
}
