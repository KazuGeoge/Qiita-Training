//
//  SearchViewController.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class SearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    private lazy var viewModel = SearchViewModel()
    private lazy var dataSouce = SearchTableViewDataSouce(viewModel: viewModel)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSouce.configure(tableView: tableView)
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        viewModel.updateSearchHistory()
        tableView.reloadData()
    }
    
    // 検索ボタンが押された時に呼ばれる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBar.showsCancelButton = true
       
        if let text = searchBar.text {
            Defaults.searchedArray.append(text)
            viewModel.showArticleList(qiitaAPI: .searchWord(text))
            viewModel.getAPI(qiitaAPI: .searchWord(text))
        }
        
        tableView.reloadData()
    }

    // キャンセルボタンが押された時に呼ばれる
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        view.endEditing(true)
        searchBar.text = ""
        tableView.reloadData()
    }

    // テキストフィールド入力開始前に呼ばれる
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        
        return true
    }
}
