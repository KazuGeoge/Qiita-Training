//
//  ProfileDetailViewModel.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//
import UIKit

class ProfileDetailTableViewDataSouce: NSObject {
    
    private let viewModel: ProfileDetailViewModel
    
    init(viewModel: ProfileDetailViewModel) {
        self.viewModel = viewModel
    }
    
    func configure(tableView: UITableView) {
        
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
}

extension ProfileDetailTableViewDataSouce: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showRouteAction(codableModel: viewModel.profileModel[indexPath.row])
    }
}

extension ProfileDetailTableViewDataSouce: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.profileModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // TODO: 各セルにcodableModelごと渡してセルクラスごとに処理する形にする
        switch viewModel.profileType {
        case .follow, .follower:
            
            if let userList = viewModel.profileModel as? [User] ,
                let userTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell {
                userTableViewCell.configure(user: userList[indexPath.row])
                
                cell = userTableViewCell
            }
        case .stock:
            if let stockArticles = viewModel.profileModel as? [Article] ,
                let articleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell {
                articleTableViewCell.configure(article: stockArticles[indexPath.row])
                
                cell = articleTableViewCell
            }
        case .tag:
            let followedTags = viewModel.profileModel as? [FollowedTag]
            cell.textLabel?.text = followedTags?[indexPath.row].id
        case .none:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 100
        
        return UITableView.automaticDimension
    }
}
