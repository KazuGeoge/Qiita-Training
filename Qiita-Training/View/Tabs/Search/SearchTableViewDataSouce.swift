//
//  SearchTableViewDataSouce.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/10.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit

class SearchTableViewDataSouce: NSObject {
    func configure(tableView: UITableView) {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
}

extension SearchTableViewDataSouce: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("遷移")
    }
}

extension SearchTableViewDataSouce: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "最近の検索"
        } else {
            return "最近閲覧したタグ"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "テスト"
        
        return cell
    }
}

