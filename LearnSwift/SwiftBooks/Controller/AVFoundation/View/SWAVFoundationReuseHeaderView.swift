//
//  SWAVFoundationReuseHeaderView.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/14.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWAVFoundationReuseHeaderView: SWBaseTableHeaderFooterView {
    
    var titleLab = UILabel()
    override func addSubViews() {
        self.contentView.backgroundColor = "#f4f4f4".color
        titleLab.textColor = .red
        titleLab.font = UIFont.boldSystemFont(ofSize: 16)
        contentView.addSubview(titleLab)
    }
    
    override func addConstraints() {
        titleLab.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(15)
        }
    }
    
    func setTitle(_ title:String)  {
        titleLab.text = title
    }
    
    
}
