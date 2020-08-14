//
//  Extensions.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/8/11.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import Foundation

extension Double {
    var km:Double {
        return self * 1_000.0
    }
    var m:Double {
        return self
    }
    var mm:Double {
        return self/100.0
    }
    var cm:Double {
        return self/100.0
    }
    var nm:Double {
        return self/1_000.0
    }
    var ft:Double {
        return self/3.28084
    }
}


struct Size {
    var width = 0.0,height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}
//通过扩展提供一个指定的初始化函数(需要指定的参数)
extension Rect {
    init(center:Point,size:Size) {
        let oroginX = center.x - (size.width)/2
        let originY = center.y - (size.height)/2
        self.init(origin: Point(x: oroginX, y: originY), size: size)
    }
}


// MARK: - Methods 3. 对存在的类型添加实例/类型方法,如下:
extension Int {
    func repetitions(task:()->Void)  {
        for _ in 0..<self {
            task()
        }
    }
}

// MARK: - 4.Mutating Instance Methods

extension Int {
    //对于结构体/枚举 要想修改self或者其属性,需要使用mutating来进行标记
    mutating  func square()  {
        self = self * self
    }
    
//  该下标方法返回一个整数中从右开始指定index的对应的数字
    subscript(digitIndex:Int)->Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self/decimalBase) % 10
    }
    
    // MARK: - 6.Nested Types
    //扩展可以为已经存在的class,枚举,结构体添加新的嵌套类型.
    enum Kind {
        case negative,zero,positive
    }
    //计算属性kind ,返回该int对应的Kind中的枚举
    var kind : Kind {
        switch self {
        case 0:
            return.zero
        case let x where x > 0 :
            return .positive
        default:
            return .negative
        }
    }
}


// MARK: - Adding Protocol Conformance With An Extension
//协议名紧跟着类型名之后,通过:分隔开,在扩展的大括号范围内添加所有协议需要提供的实现.

extension Dice:TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

extension SnakesAndLadders:TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares."
    }
}


//仅仅保存了这些实现了TextRepresentable 协议的元素
extension Array:TextRepresentable where Element:TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map{$0.textualDescription}
        return "[" + itemsAsText.joined(separator: ",") + "]"
    }
}
