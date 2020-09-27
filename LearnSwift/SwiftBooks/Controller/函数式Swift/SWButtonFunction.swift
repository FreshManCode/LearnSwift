//
//  SWButtonFunction.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/9/24.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

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
