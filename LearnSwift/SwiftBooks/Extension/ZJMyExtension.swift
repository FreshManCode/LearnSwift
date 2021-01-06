//
//  ZJMyExtension.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/6.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//  Swift中的Runtime

import Foundation
import UIKit
import NVActivityIndicatorView

typealias ButtonEventBlock = (UIButton)->()

extension UIButton {
    
    /// 给button快速绑定方法
    /// - Parameter event: 事件回调
    func addButtonEvent(_ event:@escaping ButtonEventBlock)  {
        self.MyButtonEvent = event
        self.addTarget(self, action: #selector(buttonEvent(sender:)), for: .touchUpInside)
    }
    
    
    private var MyButtonEvent:ButtonEventBlock? {
        set {
            objc_setAssociatedObject(self, &MyExtensionKey.ButtonEvent, newValue, .OBJC_ASSOCIATION_COPY)
        }
        get {
            return objc_getAssociatedObject(self, &MyExtensionKey.ButtonEvent) as? ButtonEventBlock
        }
    }
    
    @objc private func buttonEvent(sender:UIButton)  {
        if let ButtonCallBack = self.MyButtonEvent {
            ButtonCallBack(sender)
        }
    }
}

extension UIViewController {
    /// 开启Loading
    func showLoading()  {
        indicatorView.startAnimating()
        self.view.addSubview(indicatorView)
        self.view.bringSubviewToFront(indicatorView)
        
    }
    
    /// 关闭Loading
    func hideLoading()  {
        indicatorView.stopAnimating()
    }
    
    /// 是否在加载中
    var isLoading:Bool {
        return indicatorView.isAnimating;
    }
    
    
    /// 利用runtime动态生成分配相关的活动中指示器
    private  var indicatorView:NVActivityIndicatorView {
         let myIndicatorView:NVActivityIndicatorView
         if let existedIndicatorView = objc_getAssociatedObject(self, &MyExtensionKey.LodingView) as? NVActivityIndicatorView {
             myIndicatorView = existedIndicatorView
         } else {
             myIndicatorView = NVActivityIndicatorView.init(frame: UIScreen.main.bounds,
                                                            type: .ballRotateChase,
                                                            color: nil,
                                                            padding: ScreenW * 0.6)
             myIndicatorView.backgroundColor = "#000000".color(alpha: 0.4)
             objc_setAssociatedObject(self,
                                      &MyExtensionKey.LodingView,
                                      myIndicatorView,
                                      .OBJC_ASSOCIATION_RETAIN)
         }
         return myIndicatorView
     }

    
}




private struct MyExtensionKey {
    static var ButtonEvent:String = "MyButtonEventKey";
    /// 活动指示器
    static var LodingView = "MyLoadingViewKey"
    
}
