//
//  SWPlayerView.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/27.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit
import AVFoundation

class SWPlayerView: UIView {
    
    var overlayView:SWOverLayerView?
    var transport:SWTransport {
        overlayView!
    }
    
    
    
    override class var layerClass: AnyClass {
        return AVPlayerLayer.classForCoder()
    }
    
    init(with player:AVPlayer) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .black
//      在Swift使用 | 运算符
        self.autoresizingMask = UIView.AutoresizingMask(rawValue:UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)
        let myLayer = self.layer as? AVPlayerLayer
        myLayer?.player = player
        
        overlayView = SWOverLayerView()
        self.addSubview(overlayView!)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.overlayView?.frame = self.bounds
    }
    
    

    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
