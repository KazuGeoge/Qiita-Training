//
//  AuthenticationViewController.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit
import WebKit
import SwiftyUserDefaults
import RxSwift

class AuthenticationViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    private let viewModel = AuthenticationViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadURL(urlString: Const.QIITA_AUTHENTICATION_LINK)
        webView.navigationDelegate = self
        observeViewModel()
    }
    
    func loadURL(urlString: String) {
        if let url = URL(string: urlString) {
            print("\(type(of: self)) WebView url: \(url)")
            webView.load(URLRequest(url: url))
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url =  navigationAction.request.url else { return }
                
        let result = url.absoluteString.hasPrefix(Const.TOKEN_LINK_PREFIX)
        
        if result {
            let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
            // TODO: 取得したアクセストークンを使用する。
            if let queryValue = urlComponents?.queryItems?.first?.value {
                // Tokenを取得したら保存して認証画面を閉じる。
                viewModel.getUserData()
                decisionHandler(.cancel)
            }
        } else {
            decisionHandler(.allow)
        }
    }
    
    private func observeViewModel() {
        viewModel.viewDismiss.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}
