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
}


