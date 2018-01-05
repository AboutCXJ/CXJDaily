//
//  CGBaseWebVC.swift
//  CivilizationGuards
//
//  Created by sfzx on 2017/8/9.
//  Copyright © 2017年 陈鑫杰. All rights reserved.
//

import UIKit
import WebKit

let estimatedProgress = "estimatedProgress"


class CXJWebVC: CXJVC {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(url: String, title: String) {
        self.init(nibName: nil, bundle: nil)
        self.urlStr = url
        self.webTitle = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var urlStr: String?
    var webTitle: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.title = self.webTitle!
        self.addBackButton(selector: nil)
        let url = URL(string: self.urlStr!)
        let request = URLRequest(url: url!)
        self.webView.load(request)
    }
    
    func setupUI() {
        self.webView.snp.makeConstraints { (make) in
            make.left.top.height.width.equalTo(self.view)
        }
        
        self.progressView.snp.makeConstraints { (make) in
            make.bottom.left.width.equalTo(self.navBarContentView)
            make.height.equalTo(1)
        }
    }
    
    
//    MARK: - 懒加载
    lazy var webView: WKWebView = {
        var webView = WKWebView()
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: estimatedProgress, options: .new, context: nil)
        self.view.addSubview(webView)
        return webView
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = UIColor.blue
        progressView.trackTintColor = UIColor.lightGray
        self.navBarContentView.addSubview(progressView)
        return progressView
    }()
    
    
    deinit {
        self.webView.removeObserver(self, forKeyPath: estimatedProgress)
    }

}


//MARK: - @protocol WKNavigationDelegate
extension CXJWebVC: WKNavigationDelegate {
    
}


//KVO
extension CXJWebVC {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == estimatedProgress {
            self.progressView.progress = Float(self.webView.estimatedProgress)
            
            if self.progressView.progress == 1 {
                self.progressView.isHidden = true
            }
        }
    }
}
