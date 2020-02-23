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
            RouteAction.shared.show(routeType: .articleDetail)
        case .tag:
            RouteAction.shared.show(routeType: .articleDetail)
        default:
            break
        }
        
        print("遷移")
    }
}

extension ProfileDetailTableViewDataSouce: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "テスト"
        
        return cell
    }
}
