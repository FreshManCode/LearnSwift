//
//  SWMeterTable.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/22.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import Foundation
let MIN_DB : Float = -60.0
let TABLE_SIZE = 300

struct SWMeterTable {
    
    let dbResolution = MIN_DB / Float(TABLE_SIZE - 1)
    let scaleFactor:Float?
    var meterTable:[Float] = []
    
    init() {
        scaleFactor = 1.0 / dbResolution
        let minAmp = dbToAmp(db: MIN_DB)
        let ampRange = 1.0 - minAmp
        let invAmpRange = 1.0 / ampRange
        for index in 0..<TABLE_SIZE {
            let decibels = Float(index) * dbResolution
            let amp = dbToAmp(db: decibels)
            let adjAmp = (amp - minAmp) * invAmpRange
            meterTable.append(adjAmp)
        }
        
    }
    
    func dbToAmp(db:Float) -> Float {
        return powf(10.0, 0.05 * db)
    }
    
    
    func valueForPower(_ power:Float) -> Float {
        if power < MIN_DB {
            return 0.0
        }
        else if power >= 0.0 {
            return 1.0
        }
        else  {
            let index = (Int)(power * scaleFactor!)
            return meterTable[index]
        }
    }
}
