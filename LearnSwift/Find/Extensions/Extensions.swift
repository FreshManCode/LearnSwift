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


//Hamster 结构体中已经实现了TextRepresentable协议中相关的方法,可以用空扩展来遵从该协议
extension Hamster:TextRepresentable{}

//使用扩展来遵从PrettyTextRepresentable协议,该协议是一个继承协议.
extension SnakesAndLadders:PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var outPut = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                outPut += "▲ "
            case let snake where snake < 0 :
                outPut += "▼ "
            default:
                outPut += "○ "
            }
        }
        return outPut
    }
}

// MARK: - Protocol Extensions (协议扩展)
extension RandomNumberGenerator {
    //遵从协议的类型可以使用协议来扩展方法,初始化函数,下标语法,或者计算属的实现方法.
    //这使得可以协议本身定义行,而不是在每个协议的个人行为或者一个全局函数.例如 RandomNumberGenerator
    //通过扩展提供一个randombool()函数, 根据random()协议函数来实现的.
    //通过对协议使用扩展,所有遵从协议的类型自动获取了这个方法,并且不需要做任何额外的修改.
    func randomBool() -> Bool  {
        return random() > 0.5
    }
}

// MARK: - Providing Default implementations
//对于TextRepresentable 协议提供一个默认的方法实现prettyTextualDescription,简单获取textualDescription属性
extension TextRepresentable {
    var prettyTextualDescription:String {
        return textualDescription
    }
}

// MARK: - Adding Constraints to Protocol Extensions
//该方法判断集合中的所有元素是不是相等.
extension Collection where Element:Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}
