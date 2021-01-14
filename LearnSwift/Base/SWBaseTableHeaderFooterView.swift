//
//  SWBaseTableHeaderFooterView.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/14.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWBaseTableHeaderFooterView: UITableViewHeaderFooterView,SWSubViewsProtocol {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubViews()
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addSubViews() {
        
    }
    
    func addConstraints() {
        
    }
    
    
    

}
