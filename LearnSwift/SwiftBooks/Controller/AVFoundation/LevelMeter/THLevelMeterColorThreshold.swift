//
//  THLevelMeterColorThreshold.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/22.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import Foundation

struct THLevelMeterColorThreshold {
    var maxValue:CGFloat?
    var color:UIColor?
    var name:String?
    
    func description() -> String {
        guard let myName = self.name else {
            return ""
        }
        return myName
    }
    
    
}
