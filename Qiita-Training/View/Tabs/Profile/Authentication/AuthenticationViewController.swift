//
//  AuthenticationViewController.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit
import WebKit

class AuthenticationViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadURL(urlString: "https://qiita.com/login?redirect_to=https%3A%2F%2Fqiita.com%2Fsettings%2Fapplications")
        webView.navigationDelegate = self
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
        
        let urlString = url.absoluteString
        
        let result = urlString.hasPrefix("https://github.com/login/oauth/authorize?client_id=")
        
        if result {
            let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
            if let queryValue = urlComponents?.queryItems?.first?.value {
                
                print("token:\(queryValue)")
                decisionHandler(.cancel)
            }
        } else {
            decisionHandler(.allow)
        }
    }
}
