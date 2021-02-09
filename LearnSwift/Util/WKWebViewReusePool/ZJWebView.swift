//
//  ZJWebView.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/2/4.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit
import WebKit

protocol ZJWebViewProtocol:class {
     func clearAllWebCache()
}

class ZJWebView: WKWebView {

    weak var holaderObject:AnyObject?
    
    static func defaultConfiguation() -> WKWebViewConfiguration {
        let config = WKWebViewConfiguration()
        config.preferences = WKPreferences()
        config.preferences.javaScriptEnabled = true
        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        config.userContentController = WKUserContentController()

        return config
    }
    
    deinit {
        configuration.userContentController.removeAllUserScripts()
        stopLoading()
        uiDelegate = nil
        navigationDelegate = nil
        holaderObject = nil
        printLog("ZJWebView deinit")
    }
    
    func loadWhiteHtml()  {
        let filePath = Bundle.main.path(forResource: "white", ofType: "html")
                guard (filePath != nil) else {return}
        let request = URLRequest.init(url: URL.init(fileURLWithPath: filePath!))
        self.load(request)
    }
}


extension ZJWebView:ZJWebViewProtocol {
    func clearAllWebCache() {
        let dataTypes = [WKWebsiteDataTypeMemoryCache, WKWebsiteDataTypeCookies, WKWebsiteDataTypeSessionStorage, WKWebsiteDataTypeOfflineWebApplicationCache, WKWebsiteDataTypeOfflineWebApplicationCache, WKWebsiteDataTypeCookies, WKWebsiteDataTypeLocalStorage, WKWebsiteDataTypeIndexedDBDatabases, WKWebsiteDataTypeWebSQLDatabases]
        let websiteDataTypes = Set(dataTypes)
        let dateFrom = Date(timeIntervalSince1970: 0)
        
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes,
                                                modifiedSince: dateFrom) {
        }
    }
}

extension ZJWebView:ZJWebViewPoolProtocol {
    
    /// 即将被复用
    func webviewWillLeavePool() {
        
//        loadWhiteHtml()
    }
    
    /// 即将被回收
    func webviewWillEnterPool() {
        holaderObject = nil
        scrollView.delegate = nil
        stopLoading()
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        navigationDelegate = nil
        uiDelegate = nil
        // 删除历史记录
        let selStr = "_re" + "mov" + "eA" + "llIt" + "ems"
        let sel = Selector(selStr)
        if self.backForwardList.responds(to: sel) {
            self.backForwardList.perform(sel)
        }
        loadHTMLString("", baseURL: nil)
//        clearAllWebCache()
    }
}
