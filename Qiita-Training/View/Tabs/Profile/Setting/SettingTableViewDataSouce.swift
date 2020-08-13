//
//  SettingTableViewDataSouce.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/06/25.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit

class SettingTableViewDataSouce: NSObject {
    
    private let viewModel: SettingViewModel
    private let routeAction: RouteAction
    
    init(viewModel: SettingViewModel, routeAction: RouteAction = .shared) {
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

extension SettingTableViewDataSouce: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        viewModel.selectCell(settingType: viewModel.typeList[indexPath.section][indexPath.row])
    }
}

extension SettingTableViewDataSouce: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.typeList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.typeList[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "アカウント" : "アプリについて"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.typeList[indexPath.section][indexPath.row].text
        return cell
    }
}


