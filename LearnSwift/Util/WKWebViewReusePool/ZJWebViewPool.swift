//
//  ZJWebViewPool.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/2/4.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//  WKWebview 复用池

import UIKit
import WebKit

//首页加载完成时发送的通知key
public let kMainControllerInitSuccessKey = "MainControllerInitSuccss"


protocol ZJWebViewPoolProtocol:class {
    func webviewWillLeavePool()
    func webviewWillEnterPool()
}


class ZJWebViewPool: NSObject {
    
    
    /// 创建单例实例对象
    static let shared = ZJWebViewPool()
    
    var count:Int = 0
    
    
    override  private init() {
        super.init()
        addInitObserver()
    }
    
    
    /// 添加初始化完成的通知
    private func addInitObserver () {
        printLog("addInitObserver")
        weak var weakSelf = self
        
        //开始准备复用池
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(initReusePool),
                                               name: kMainControllerInitSuccessKey.NotificationName,
                                               object: nil)
        
        
        
        //开始准备复用池
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didReceiveMemoryWarning),
                                               name: UIApplication.didReceiveMemoryWarningNotification,
                                               object: nil)
    }
    
    
    /// 初始化准备
    @objc  func initReusePool()  {
        printLog("initReusePool")
        //      放在主线程中异步初始化WKWebview
        self.dispatchAfter(0.1) {
            self.prepareReuseWebView()
        }
    }
    
    //收到内存警告
    @objc func didReceiveMemoryWarning()  {
        self.lock.wait()
        self.reusableWebViewSet.removeAll()
        self.lock.signal()
    }
    
    
    /// 初始化一个wkwebview
    func prepareReuseWebView()  {
        guard reusableWebViewSet.count <= 0 else {
            return
        }
        let webView = ZJWebView(frame: CGRect.zero,
                                configuration: ZJWebView.defaultConfiguation())
        self.reusableWebViewSet.insert(webView)
    }
    
    func tryCompleteWeakHolders()  {
        self.lock.wait()
        let shouldReusedWebViewSet = visibleWebViewSet.filter({$0.holaderObject == nil})
        for webview in shouldReusedWebViewSet {
            webview.webviewWillEnterPool()
            visibleWebViewSet.remove(webview)
            reusableWebViewSet.insert(webview)
        }
        lock.signal()
    }
    
    
    
    deinit {
        clearAllReuseableWebviews()
    }
    
    
    lazy private var reusableWebViewSet:Set<ZJWebView> = {
        let mySet = Set<ZJWebView>()
        return mySet
    }()
    
    lazy private var visibleWebViewSet:Set<ZJWebView> = {
        let mySet = Set<ZJWebView>()
        return mySet
    }()
    
    lazy var lock:DispatchSemaphore = {
        let myLock = DispatchSemaphore(value: 1)
        return myLock
    }()
    
}



extension ZJWebViewPool {
    func reusedWebView(forHolder holder:AnyObject?) -> ZJWebView {
        assert(holder != nil, "holder 为nil")
        guard let holder = holder else { return
            ZJWebView(frame: .zero, configuration: ZJWebView.defaultConfiguation())
        }
        tryCompleteWeakHolders()
        let webview:ZJWebView
        lock.wait()
        if reusableWebViewSet.count > 0 {
            //缓存池中存在
            webview = reusableWebViewSet.randomElement()!
            reusableWebViewSet.remove(webview)
            reusableWebViewSet.insert(webview)
            //出回收池之前初始化
            webview.webviewWillLeavePool()
        } else {
            //缓存池中没有,创建新的
            webview = ZJWebView(frame: .zero, configuration: ZJWebView.defaultConfiguation())
            visibleWebViewSet.insert(webview)
        }
        webview.holaderObject = holder
        lock.signal()
        return webview
    }
    
    
    /// 回收可复用的webvie到复用池中
    /// - Parameter webview: webView
    func recycleReusedWebview(_ webview:ZJWebView?)  {
        guard let webview = webview else { return }
        lock.wait()
        if visibleWebViewSet.contains(webview) {
            //进入回收池之前清理
            webview.webviewWillEnterPool()
            visibleWebViewSet.remove(webview)
            reusableWebViewSet.insert(webview)
        }
        lock.signal()
    }
    
    
    /// 移除并销毁复用池的webview
    func clearAllReuseableWebviews()  {
        lock.wait()
        for webview in reusableWebViewSet {
            webview.webviewWillEnterPool()
        }
        reusableWebViewSet.removeAll()
        lock.signal()
    }
}
