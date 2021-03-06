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
        
        tableView.register(UINib(nibName: UserTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: UserTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: ArticleTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ArticleTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: TagTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: TagTableViewCell.reuseIdentifier)
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
        
        switch viewModel.profileType {
        case .follow, .follower:
            if let userList = viewModel.profileModel as? [User] ,
                let userTableViewCell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier, for: indexPath) as? UserTableViewCell {
                userTableViewCell.configure(user: userList[indexPath.row])
                
                cell = userTableViewCell
            }
        case .stock:
            if let stockArticles = viewModel.profileModel as? [Article] ,
                let articleTableViewCell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.reuseIdentifier, for: indexPath) as? ArticleTableViewCell {
                articleTableViewCell.configure(article: stockArticles[indexPath.row])
                
                cell = articleTableViewCell
            }
        case .tag:
            if let followedTag = viewModel.profileModel as? [FollowedTag] ,
                let tagTableViewCell = tableView.dequeueReusableCell(withIdentifier: TagTableViewCell.reuseIdentifier, for: indexPath) as? TagTableViewCell {
                tagTableViewCell.configure(followedTag: followedTag[indexPath.row])
                cell = tagTableViewCell
            }
        case .none:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        tableView.estimatedRowHeight = 70
        
        if case viewModel.profileType = ProfileType.stock {
            tableView.estimatedRowHeight = 100
        } else if case viewModel.profileType = ProfileType.tag {
            return 70
        }
        
        return UITableView.automaticDimension
    }
}
