//
//  ProfileTableViewDataSouce.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/10.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit

class ProfileTableViewDataSouce: NSObject {
    
    private let viewModel: ProfileViewModel
    private let routeAction: RouteAction
    
    init(viewModel: ProfileViewModel, routeAction: RouteAction = .shared) {
        self.routeAction = routeAction
        self.viewModel = viewModel
    }
    
    func configure(tableView: UITableView) {
        
        tableView.register(UINib(nibName: ArticleTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ArticleTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
}

extension ProfileTableViewDataSouce: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        routeAction.show(routeType: .articleDetail(viewModel.articleList[indexPath.row]))
        print("遷移")
    }
}

extension ProfileTableViewDataSouce: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articleList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
  
        return "\(viewModel.articleList.count)件の投稿"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()

        if let articleCell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.reuseIdentifier, for: indexPath) as? ArticleTableViewCell {
            articleCell.configure(article: viewModel.articleList[indexPath.row])
            
            cell = articleCell
        }
        
        return cell
    }
}


