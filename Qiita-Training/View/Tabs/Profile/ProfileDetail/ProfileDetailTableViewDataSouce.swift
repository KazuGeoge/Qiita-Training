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
    var articleList: [Article] = []
    
    init(viewModel: ProfileDetailViewModel) {
        self.viewModel = viewModel
    }
    
    func configure(tableView: UITableView) {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
}

extension ProfileDetailTableViewDataSouce: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch viewModel.profileType {
        case .follow:
            RouteAction.shared.show(routeType: .profile)
        case .follower:
            RouteAction.shared.show(routeType: .profile)
        case .stock:
            RouteAction.shared.show(routeType: .articleDetail(articleList[indexPath.row]))
        case .tag:
            RouteAction.shared.show(routeType: .articleDetail(articleList[indexPath.row]))
        default:
            break
        }
        
        print("遷移")
    }
}

extension ProfileDetailTableViewDataSouce: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.codableModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // TODO: 各セルにcodableModelごと渡してセルクラスごとに処理する形にする
        switch viewModel.profileType {
        case .follow, .follower:
            let users = viewModel.codableModel as? [User]
            cell.textLabel?.text = users?[indexPath.row].id
        case .stock:
            let stockArticles = viewModel.codableModel as? [Article]
            cell.textLabel?.text = stockArticles?[indexPath.row].title
        case .tag:
            let followedTags = viewModel.codableModel as? [FollowedTag]
            cell.textLabel?.text = followedTags?[indexPath.row].id
        case .none:
            break
        }
        
        return cell
    }
}
