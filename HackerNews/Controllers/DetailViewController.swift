//
//  DetailViewController.swift
//  HackerNews
//
//  Created by Dimas Wisodewo on 28/01/23.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKUIDelegate {
    
    var url: String?
    private var webView: WKWebView!
        
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide tab bar
        tabBarController?.tabBar.isHidden = true
        
        guard let safeUrl = url else { return }
        let myURL = URL(string: safeUrl)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
}
