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

extension UIView {
    
    /// 控件的起始Y坐标
    var originY:CGFloat {
        return self.frame.origin.y
    }
    
    /// 控件的起始X坐标
    var originX:CGFloat {
        return self.frame.origin.x
    }
    
    
    /// 控件的高度
    var height:CGFloat {
        return self.frame.size.height
    }
    
    
    /// 控件的宽度
    var width:CGFloat {
        return self.frame.size.width
    }
    
    /// 控件的最大X坐标 (originx + width)
    var maxX:CGFloat {
        return originX + width
    }
    
    /// 控件的最大Y坐标 (originy + height)
    var maxY:CGFloat {
        return originY + height
    }
    
    func cornerRadius(radius:CGFloat)  {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func addTopRadius(radis:CGFloat)  {
        self.layoutIfNeeded()
        let frame = self.frame
        let topConer = UIRectCorner(rawValue: (UIRectCorner.topLeft.rawValue | UIRectCorner.topRight.rawValue))
        let bezierPath = UIBezierPath.init(roundedRect: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height), byRoundingCorners: topConer , cornerRadii: CGSize(width: radis, height: radis))
        let layer = CAShapeLayer()
        layer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        layer.path = bezierPath.cgPath
        self.layer.mask = layer
    }
    
    func addBottomRadius(radis:CGFloat)  {
        self.layoutIfNeeded()
        let frame = self.frame
        let bottomCorner = UIRectCorner(rawValue: (UIRectCorner.bottomLeft.rawValue | UIRectCorner.bottomRight.rawValue))
        let bezierPath = UIBezierPath.init(roundedRect: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height), byRoundingCorners: bottomCorner , cornerRadii: CGSize(width: radis, height: radis))
        let layer = CAShapeLayer()
        layer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        layer.path = bezierPath.cgPath
        self.layer.mask = layer
    }
}



public struct MyExtensionKey {
    /// 快速添加button事件
    static var ButtonEvent:String = "MyButtonEventKey";
    /// 活动指示器
    static var LodingView = "MyLoadingViewKey"
    /// TextView
    static var TextView = "MyTextViewKey"
    /// Notification
    static var Notification = "MyNotificationKey"
}
