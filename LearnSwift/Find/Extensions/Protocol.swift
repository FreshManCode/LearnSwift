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
