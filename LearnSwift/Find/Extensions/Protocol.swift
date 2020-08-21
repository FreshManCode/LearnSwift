//
//  Protocol.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/8/13.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import Foundation

protocol FullyNamed {
    var fullName:String {
        get
    }
}

protocol RandomNumberGenerator {
    func random()  -> Double
}

protocol Togglable {
    mutating func toggle()
}


protocol SomePtorocol {
    init()
}

// MARK: - Delegation
protocol DiceGame {
    var dice:Dice {get}
    func play()
}

protocol DiceGameDelegate:AnyObject {
    func gameDidStart(_ game:DiceGame)
    func game(_ game:DiceGame,didStartNewTurnWithDiceRoll diceRoll:Int)
    func gameDidEnd(_ game:DiceGame)
}


// MARK: - Adding Protocol Conformance With An Extension
protocol TextRepresentable {
    var textualDescription:String {get}
}


// MARK: - Protocol Inheritance
// 该协议继承了TextRepresentable,任何需要满足PrettyTextRepresentable协议的类型,
//需要满足PrettyTextRepresentable的协议+TextRepresentable的协议.
protocol PrettyTextRepresentable : TextRepresentable {
    var prettyTextualDescription:String {get}
}



// MARK: - Class-Only Protocols
protocol SomeClassOnlyprocol : AnyObject,TextRepresentable {
    
}


// MARK: - Checking for Protocol Conformance

protocol HasArea {
    var area:Double{get}
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius:Double
    var area:Double {
        return pi * radius * radius
    }
    init(radius:Double) {
        self.radius = radius
    }
}

class Country: HasArea {
    var area: Double
    init(area:Double) {
        self.area = area
    }
}

//未遵循HasArea 协议
class Animal {
    var legs:Int
    init(legs:Int) {
        self.legs = legs
    }
}



// MARK: - Optional Protocol Requirements (可选协议需求)
@objc protocol CounterDataSource {
//  定义了一个可选型的函数,一个可选型的变量
    @objc optional func increment(forCount count:Int) -> Int
    @objc optional var fixedIncremnt:Int {get}
}

