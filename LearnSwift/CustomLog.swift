//
//  CustomLog.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/8/24.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//  自定义Log 在Build Settings ->Swift Complier - Code Generation 配置对应的环境参数

import Foundation


func printLog(_ items: Any...,
    logError: Bool = false,
    file: String = #file,
    method: String = #function,
    line: Int = #line)
{
    if logError {
        print(message: items, fileName: file,methodName: method,lineNumber: line)
    } else {
        #if RELEASE
        #else
        print(message: items, fileName: file,methodName: method,lineNumber: line)
        #endif
        //        ADHOC-OFFICIAL
        //        ADHOC-Test
        //        ADHOC-Link
        //        ADHOC-OFFICIAL
        //        RELEASE
        //        DEVELOPER
        //        DEBUG
    }
}

private func print<T>(message: T, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line) {
    //获取当前时间
    let now = Date()
    // 创建一个日期格式器
    let dformatter = DateFormatter()
    dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    // 要把路径最后的字符串截取出来
    let lastName = ((fileName as NSString).pathComponents.last!)
    print("\(dformatter.string(from: now)) [\(lastName)][第\(lineNumber)行] [\(methodName)] \n\t \(message)")
}
