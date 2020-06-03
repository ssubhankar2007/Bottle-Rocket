//
//  InternetViewController.swift
//  Bottle Rocket
//
//  Created by Subhankar Ghosh on 28/05/20.
//  Copyright © 2020 Subhankar Ghosh. All rights reserved.
//

import UIKit
import WebKit

class InternetViewController: UIViewController {
    private let url = "https://www.bottlerocketstudios.com"
    var webView:WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupWebView()
        setupConstraints()
        addBrowserButtons()
    }
    
    func addBrowserButtons() {
        let backButton = UIBarButtonItem.init(image: UIImage(named:"webBack"), style: .plain, target: self, action: #selector(goBack))
        let reloadButton = UIBarButtonItem.init(image: UIImage(named:"webRefresh"), style: .plain, target: self, action: #selector(reaload))
        let forwardButton = UIBarButtonItem.init(image: UIImage(named:"webForward"), style: .plain, target: self, action: #selector(goForward))
        self.navigationItem.leftBarButtonItems = [backButton, reloadButton, forwardButton]
    }
    
    func setupConstraints(){
        webView?.translatesAutoresizingMaskIntoConstraints = false
        guard let horizontalConstraint = webView?.centerXAnchor.constraint(equalTo: view.centerXAnchor) else { return  }
        guard let verticalConstraint = webView?.centerYAnchor.constraint(equalTo: view.centerYAnchor) else { return  }
        guard let widthConstraint = webView?.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0) else {return}
        guard let heightConstraint = webView?.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0) else {return}
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func setupWebView(){
        let rect = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0)
        let setup = WKWebViewConfiguration()
        webView = WKWebView(frame: rect, configuration: setup)
        guard let url = URL(string: url) else { return }
        let myRequest = URLRequest(url: url)
        view.addSubview(webView!)
        webView?.load(myRequest)
    }
    
    @objc func goBack(sender:UIBarButtonItem) {
        webView?.goBack()
    }
    
    @objc func reaload(sender:UIBarButtonItem) {
        webView?.reload()
    }
    
    @objc func goForward(sender:UIBarButtonItem) {
        webView?.goForward()
    }
}
