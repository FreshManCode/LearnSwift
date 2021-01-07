//
//  ZJMySetTypeExtension.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/7.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import Foundation

extension Array {
    
    /// 对数组中的所有元素做变换
    /// - Parameter transform: 条件变换
    /// - Returns: 按照条件变换之后的数组
    func myReduce(_ transform:(Element)->Element) -> [Element] {
        var result = [Element]()
        for Ele in self {
            result.append(transform(Ele))
        }
        return result
    }
    
    
    
    

}



extension Dictionary {
    
    /// 根据某些条件筛选 dictionary中的key
    /// - Parameter transform: 筛选变换
    /// - Returns: 结果
    func myFilter(_ transform:(Key)->Bool) -> [Key:Value] {
        var result = [Key:Value]()
        for (key,value) in self {
            if transform(key) {
                result[key] = value
            }
        }
        return result
    }

     
    /// 根据某些情况对Dictionary中的key,value做什么处理,并给予初始值
    /// (使用where 关键词来限制value是遵从RangeReplaceableCollection,也就是value可以使用"+"来进行操作)
    /// - Parameters:
    ///   - initial: 初始值
    ///   - transform: 变化处理
    /// - Returns: 处理之后的结果
    func myQuery(_ initial:Value, _ transform:(Key,Value)->Value) -> Value where Dictionary.Value:RangeReplaceableCollection {
        var result = initial
        for (key,value) in self {
            result = result + transform(key,value)
        }
        return result
    }
    
    
    /// 按照Key的降序排列之后,对Dictionary中的key,value做什么处理,并给予初始值
    /// (使用where 关键词来限制value是遵从RangeReplaceableCollection,也就是value可以使用"+"来进行操作)
    /// - Parameters:
    ///   - initial: 初始值
    ///   - transform: 变形操作
    /// - Returns: 结果
    func sortMyQuery (_ initial:Value,_ transform:(Key,Value)->Value) -> Value where Dictionary.Key:Comparable,Dictionary.Value:RangeReplaceableCollection {
        var result = initial
        let sortedKeys =
        self.keys.sorted { (value1, value2) -> Bool in
            return value1 > value2
        }
        for myKey in sortedKeys {
            result = result + transform(myKey,self[myKey]!)
        }
        return result
    }
    
    
    
}
