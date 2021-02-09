//
//  SWImproveWKWebViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/2/4.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWImproveWKWebViewController: UIViewController {

    let returnURLS:[String] = [
    "https://merchant.pay.sina.com.cn/notice/detail?id=8009&noticeType=1&categoryId=1",
    "https://merchant.pay.sina.com.cn/notice/detail?id=8002&noticeType=1&categoryId=1",
    "https://merchant.pay.sina.com.cn/notice/detail?id=8008&noticeType=1&categoryId=2"]
    var webview:ZJWebView?
    
    let startTime = CFAbsoluteTimeGetCurrent()
    var endTime:CFAbsoluteTime?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        initWebview()
        addObservers()
        loadWebView()
    }
    
    func configNav()  {
        self.title = "WkWebView秒开实践"
    }
    
    
    
    func initWebview()  {
        webview = ZJWebViewPool.shared.reusedWebView(forHolder: self)
        self.view.addSubview(webview!)
        webview?.frame = CGRect(x: 0, y: navHeight, width: ScreenW, height: ScreenH - navHeight)
        if #available(iOS 11.0, *) {
            webview!.scrollView.contentInsetAdjustmentBehavior = .never
        }else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.view.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.top.equalTo(webview!).offset(2.0)
            make.left.right.equalTo(0)
            make.height.equalTo(2.0)
        }
    }
    
    func loadWebView()  {
        let count = ZJWebViewPool.shared.count % 3
        let urlRequest = URLRequest.init(url: URL.init(string: returnURLS[count])!)
        ZJWebViewPool.shared.count += 1
        webview!.load(urlRequest)
    }
    
    private func addObservers () {
        webview!.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webview!.addObserver(self, forKeyPath: "backgroundColor", options: .new, context: nil)
    }
    
    private func removeObservers () {
        webview!.removeObserver(self, forKeyPath: "estimatedProgress")
        webview!.removeObserver(self, forKeyPath: "backgroundColor")
    }
    
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" && object as! NSObject == webview! {
            let progress = Float(webview!.estimatedProgress)
            if progress >= 0.5 {
                webview?.alpha = 1.0
            } else {
                webview?.alpha = 0.0
            }
            if progress >= 1.0 {
                endTime = CFAbsoluteTimeGetCurrent()
                printLog("total time is:\(endTime! - startTime)")
            } else {
                printLog("progress is:\(progress)")
            }
            progressView.alpha = 1.0
            progressView.setProgress(progress, animated: true)
            if webview!.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3,
                               delay: 0.3,
                               options: .curveEaseOut) {
                    self.progressView.alpha = 0
                }
                completion: { (finished) in
                    self.progressView.setProgress(0.0, animated: false)
                }
            }
        }
        else if keyPath == "backgroundColor" && object as! NSObject == webview!.scrollView {
            let color = change![NSKeyValueChangeKey.newKey] as? UIColor
            if color != .clear {
                webview!.scrollView.backgroundColor = .clear
            }
        }
    }
    
    
    lazy var progressView:UIProgressView = {
        let view = UIProgressView()
        view.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
        view.tintColor = "0xffb824".color
        view.trackTintColor = .clear
        return view
    }()
    
    deinit {
        printLog("deinit")
        removeObservers()
        ZJWebViewPool.shared.tryCompleteWeakHolders()
    }

   

}
