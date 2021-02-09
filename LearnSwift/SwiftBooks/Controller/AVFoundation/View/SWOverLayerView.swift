//
//  SWOverLayerView.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/27.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWOverLayerView: UIView {
    
    
    @objc func doneEvent() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(topToolBar)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    lazy var topToolBar:UIToolbar = {
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 50))
        let doneItem = UIBarButtonItem.init(title: "Down",
                                            style: .done,
                                            target: self,
                                            action: #selector(doneEvent))
        toolBar.backgroundColor = "#f4f4f4".color
        return toolBar
    }()
    
    
    
    

}
