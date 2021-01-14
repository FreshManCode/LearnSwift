//
//  SWBaseView.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/11.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWBaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        zjAddSubviews()
        zjAddConstrints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func zjAddSubviews()  {
        
    }
    
    func zjAddConstrints()  {
        
    }

}
