//
//  CompositionProtocol.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/8/17.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import Foundation
protocol Named {
    var name:String {get}
}

protocol Aged {
    var age:Int {get}
}

struct Person:Named,Aged {
    var name: String
    var age: Int
}


class Location  {
    var latitude:Double
    var longitude:Double
    
    init(latitude:Double,longitude:Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

class City : Location,Named {
    var name:String
    init(name:String,latitude:Double,longitude:Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}

