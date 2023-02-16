//
//  DetailViewController.swift
//  HackerNews
//
//  Created by Dimas Wisodewo on 28/01/23.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKUIDelegate {
    
    static let shared: DetailViewController = DetailViewController()
    
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
        
        // Add right bar button item
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "globe"), style: .plain, target: self, action: #selector(openTapped))
        
        guard let safeUrl = url else { return }
        let myURL = URL(string: safeUrl)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
 
    // Open with external browser
    @objc func openTapped() {
        guard let safeUrl = url else { return }
        guard let link = URL(string: safeUrl) else { return }
        UIApplication.shared.open(link)
    }
}
