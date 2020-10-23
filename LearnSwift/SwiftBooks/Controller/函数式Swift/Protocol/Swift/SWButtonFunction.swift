//
//  SWButtonFunction.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/9/24.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

/*
 
 在面向对象的分析和设计中,有一个非常重要的原则是"面向接口编程",在Swift或者OC中没有接口这一说法,与之对应的就是"面向协议编程".
 面向协议编程使得面向对象类型(类,结构体,和枚举)的定义与实现分离,协议作为数据类型暴露给使用者,使用者不用关心具体的实现细节,
 从而提供代码的扩展性和可复用性.
 
 协议定义了方法,属性,或者其他需求用来满足一个特殊任务或者一段功能的蓝图.协议可以通过继承类,结构体,枚举来提供这些需要的实现.
 任何满足协议的需求类,称为遵从了该协议.
 
 相对于OC,Swift可以做到protocol协议方法的具体默认实现(通过extension),更好的实现了代码的复用.但是OC不行.
 (比如一个统计事件功能,A界面,B界面等多个界面都有,实现这些功能有几种办法,一种就是胶水代码,在A,B分别去Copy,paste,
 一种就是A,B的共同功能剥离出来,然和使用一个base类,另一种就是使用protocol,A,B都遵从该协议即可).之所以推荐使用协议是因为,
 如果后续又增加了点赞,或者打榜等公共功能时,这些都放到base类,base类会变得越来越杂,最后让人头疼的common类.而且会导致有些类
 可能并不需要其中的某个功能,但是继承了base之后,就想摆脱也摆脱不掉了.
 
 */

import Foundation
import UIKit
import SCLAlertView

//where Self:UIViewController 如果在协议后面加上限制,就可以限定特定Type可以遵从协议
protocol SWButtonRequestProtocol   {
    /// 点赞 操作
    /// - Parameter itemID: 商品ID
    func doFavor(itemID:String)
    
    /// 收藏操作
    /// - Parameter itemID: 商品ID
    func doCollect(itemID:String)
}


//使用对协议的扩展,实现相关点赞,收藏等操作
extension SWButtonRequestProtocol {
    func doFavor(itemID:String){
        let text = "点赞的itemID:\(itemID)"
        printLog(text)
        SCLAlertView().showSuccess("点赞操作", subTitle: text)
    }
    
    func doCollect(itemID:String) {
        let text = "收藏的itemID:\(itemID)"
        SCLAlertView().showSuccess("收藏操作", subTitle: text)
    }
}

extension SWPOPVC {
    func defaultData()  {
        for idex in 1...15 {
            let name = "这个水果拼盘看起来还是很好的 id是:\(idex)"
            let model = SWProtocolTestModel(name: name, IDNumber: String(idex))
            dataArray.append(model)
        }
    }
}
