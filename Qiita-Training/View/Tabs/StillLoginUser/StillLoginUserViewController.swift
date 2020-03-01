//
//  StillLoginUserViewController.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/28.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class StillLoginUserViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    var feed: FeedViewController?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        observeButton()
    }
    
    private func observeButton() {
        loginButton.rx.tap
        .subscribe({ _ in
            self.feed!.setUpSwipeMenuView()
        })
        .disposed(by: disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
