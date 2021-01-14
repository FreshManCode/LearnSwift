//
//  SWSubViewsProtocol.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/14.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import Foundation


/// UIView 相关子组件
protocol SWSubViewsProtocol {
    /// 添加子控件
     func addSubViews()
    /// 添加约束
     func addConstraints()
    
    /// 重用标识符
    static func CID() -> String
}


///添加相关默认实现
extension SWSubViewsProtocol {
    func addSubViews()  {
        printLog("this is default addsubViews method \(self))")
    }
    
    func addConstraints()  {
        printLog("this is default addConstraints method \(self)")
    }
    
    static func CID() -> String {
        return NSStringFromClass(self as! AnyClass)
    }
}
