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

