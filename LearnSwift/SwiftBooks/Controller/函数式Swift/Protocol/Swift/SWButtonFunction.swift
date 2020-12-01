//
//  SWButtonFunction.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/9/24.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

/*
 
 Swift中面向协议编程
 
 对比一下与OC中的面向协议的不同,会发现Swift的面向协议更加强大,灵活.主要体现在下面.
 
 1.Objective-C 中的“协议,只有类可以声明遵循协议，struct,enum,等都不可以.
 2.在Swift中,不仅仅是类可以遵从协议(使用协议),值类型也可以遵从协议,比如:struct和 enum (如事例中的结构体类型 ZJTestPerson 遵守了,Sequence协议,现在可以使用== 来比较两个结构体是否相等了.)
 3.Swift中的协议具有OC中协议不具备的协议扩展功能
 
 

 下面对Swift的面向协议编程做简单的讲解.
 
 面向协议编程使得面向对象类型(类,结构体,和枚举)的定义与实现分离,协议作为数据类型暴露给使用者,使用者不用关心具体的实现细节,
 从而提供代码的扩展性和可复用性.
 
 协议定义了方法,属性,或者其他需求用来满足一个特殊任务或者一段功能的蓝图.协议可以通过继承类,结构体,枚举来提供这些需要的实现.
 任何满足协议的需求类,称为遵从了该协议.
 
 相对于OC,Swift可以做到protocol协议方法的具体默认实现(通过extension),更好的实现了代码的复用.但是OC不行.
 (比如一个统计事件功能,A界面,B界面等多个界面都有,实现这些功能有几种办法,一种就是胶水代码,在A,B分别去Copy,paste,
 一种就是A,B的共同功能剥离出来,然和使用一个base类,另一种就是使用protocol,A,B都遵从该协议即可).之所以推荐使用协议是因为,
 如果后续又增加了点赞,或者打榜等公共功能时,这些都放到base类,base类会变得越来越杂,最后成为让人头疼的common类.而且会导致有些类
 可能并不需要其中的某个功能,但是继承了base之后,就想摆脱也摆脱不掉了.
 
 */

import Foundation
import UIKit
import SCLAlertView

//where Self:UIViewController 如果在协议后面加上限制,就可以限定特定Type可以遵从协议
//SWButtonRequestProtocol 协议给定了两个功能:
//1.点赞功能
//2.收藏功能
protocol SWButtonRequestProtocol   {
    /// 点赞 操作
    /// - Parameter itemID: 商品ID
    func doFavor(itemID:String)
    
    /// 收藏操作
    /// - Parameter itemID: 商品ID
    func doCollect(itemID:String)
    
    /// 统计功能 (比如统计用户的行为,或者某些页面的打开次数,按钮的点击次数等)
    /// - Parameter eventName:统计的事件名
    func doCollect(eventName:String)
    
}


//使用对协议的扩展,实现相关点赞,收藏等操作(收藏,点赞的默认操作/通用操作)
//如果某个试图中的收藏操作并不是默认的操作,则可以自己去实现自定义的个性操作.
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
    
    func doCollect(eventName:String) {
        SCLAlertView().showSuccess("统计操作", subTitle: eventName)
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


extension Sequence {
    //方法differAll检查了一个数组中的元素是否都符合某个条件.它被定为为一个Sequence协议的扩展.
    func differAll(predicate:(Iterator.Element)->Bool)->Bool  {
        for x in self where !predicate(x) {
            return false
        }
        return true
    }
    
    
    
    /// 匹配出所有满足条件的Item
    /// - Parameter predicate: 匹配条件
    /// - Returns: 数组
    func matchAll(predicate:(Iterator.Element)->Bool) -> [Iterator.Element] {
        var result = [Iterator.Element]()
        for x in self where predicate(x) {
            result.append(x)
        }
        return result
    }
}


/// 遵从 Equatable 协议的结构体类型
struct ZJTestPerson :Equatable {
    
    var name :String?
    var age : Int?
    init(name:String,age:Int) {
        self.name = name
        self.age = age
    }
//  实现协议中的 == 运算符
    static func == (left:ZJTestPerson,right:ZJTestPerson)->Bool {
        return left.name == right.name && left.age == right.age
    }
    
}
