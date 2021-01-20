//
//  SWUtilExtension.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/10/9.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit
import Foundation

public extension  NSObject {
    
    typealias NotificationEvent = (Notification)->()
    
    /// 快速添加通知
    /// - Parameters:
    ///   - name: 通知名称
    ///   - object: 需要添加的object
    ///   - callBack: 回调
    func addNotification(name:String,
                         object:Any?,
                         _ callBack : @escaping NotificationEvent) {
        self.MyNotificationEvent = callBack
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(myNotiEvent(sender:)),
                                               name: name.NotificationName,
                                               object: object)
    }
    
    func addNoti(notiName:Notification.Name,
                 object:Any?,
                 _ callBack : @escaping NotificationEvent)  {
        self.MyNotificationEvent = callBack
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(myNotiEvent(sender:)),
                                               name: notiName,
                                               object: object)
    }
    
    
    /// 简单的通知
    /// - Parameters:
    ///   - name: 通知名称
    ///   - object: 需要的object
    func mySimplePost(name:String,object:Any?)  {
        myPost(name: name, object: object, userInfo: nil)
    }
    
    
    /// 自定义通知
    /// - Parameters:
    ///   - name: 通知名称
    ///   - object: 是否传入Object
    ///   - userInfo: userinfo
    func myPost(name:String,object:Any?,userInfo:[AnyHashable:Any]?)  {
        NotificationCenter.default.post(name: name.NotificationName, object: object,userInfo:userInfo)
    }
    var ScreenW : CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    var ScreenH : CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    /// 延迟 多少 s 执行操作
    /// - Parameters:
    ///   - time: 延迟时间
    ///   - execute: 时间到了之后,执行相关操作
    func dispatchAfter(_ time:Float,execute:@escaping ()-> Void)  {
        let millSeconds = Int(time * 1000)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(millSeconds), execute: execute)
    }
    
    
    /// 异步主线程
    /// - Parameter execute: 执行回调
    func dispatchMainAsyc(execute:@escaping ()->Void)  {
        DispatchQueue.main.async(execute: execute)
    }
    
    
    /// 异步分线程执行
    /// - Parameter execute: 执行回调
    func dispatchAsync(execute:@escaping ()->Void)  {
        DispatchQueue.global().async(execute: execute)
    }
    
    
    /// 是否是Iphonex
    var isIphonex:Bool {
        return safaArea > 0 ? true : false
    }
    
    /// 底部安全域
    var safaArea:CGFloat {
        if #available(iOS 11, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        }
        return 0
    }
    
    /// 顶部刘海
    var topHairMargin:CGFloat {
        if #available(iOS 11, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
        }
        return 0
    }
    
    /// App版本号
    var AppVersion:String {
        guard let version =  Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String else {
            return "App_Unknown"
        }
        return version
    }
    
    /// App名称
    var AppName:String {
        guard let name = Bundle.main.infoDictionary!["CFBundlenameString"] as? String else {
            return "LearnSwift"
        }
        return name
    }
    
    
    
    private var MyNotificationEvent:NotificationEvent? {
        set {
            objc_setAssociatedObject(self, &MyExtensionKey.Notification, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            objc_getAssociatedObject(self, &MyExtensionKey.Notification) as? NotificationEvent
        }
    }
    
    @objc private func myNotiEvent(sender:Notification)  {
        if let CallBack = self.MyNotificationEvent {
            CallBack(sender)
        }
    }
}

extension String {
    
    func color(alpha:CGFloat) -> UIColor {
        let hexString = self
        
        let scanner = Scanner(string: hexString )
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    var color:UIColor {
        return color(alpha: 1)
    }
    
    /// 根据name快速创建NotificationName
    var NotificationName:NSNotification.Name {
        NSNotification.Name.init(self)
    }
    
    
    /// 存储在documentDirectory 中的文件名
    var documentFilePath:String {
        assert(self.count > 0, "请输入正确的文件名")
        let directoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        return (directoryPath! as NSString).appendingPathComponent(self)
    }
    
    
    /// 存储在Temporary 中的文件名
    var temporaryFilePath:String {
        assert(self.count > 0, "请输入正确的文件名")
        let temporaryPath = NSTemporaryDirectory() as NSString
        let filePath = temporaryPath.appendingPathComponent(self)
        return filePath
    }
    
    
    
}




