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
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
  
        let postNum = 0
        return "\(postNum)件の投稿"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // 作成したセルクラスを使用する
        if !viewModel.articleList.isEmpty {
            cell.textLabel?.text = viewModel.articleList[indexPath.row].title
        }
        
        return cell
    }
}


