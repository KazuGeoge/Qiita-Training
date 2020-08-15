//
//  SearchTableViewDataSouce.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/10.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit

class SearchTableViewDataSouce: NSObject {
    
    private let viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    func configure(tableView: UITableView) {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
}

extension SearchTableViewDataSouce: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let qiitaAPI = indexPath.section == 0 ?
            QiitaAPI.searchWord(viewModel.searchedArray[indexPath.row], 1) : QiitaAPI.searchTag(viewModel.tagArray[indexPath.row])
        
        RouteAction.shared.show(routeType: .articleList(qiitaAPI))
        viewModel.getAPI(qiitaAPI: qiitaAPI)
    }
}

extension SearchTableViewDataSouce: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? viewModel.searchedArray.count : viewModel.tagArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "最近の検索" : "最近閲覧したタグ"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = viewModel.searchedArray[indexPath.row]
        } else {
            cell.textLabel?.text = viewModel.tagArray[indexPath.row]
        }
        
        return cell
    }
}

