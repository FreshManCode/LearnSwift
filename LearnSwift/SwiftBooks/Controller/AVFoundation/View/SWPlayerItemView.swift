//
//  SWPlayerItemView.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/15.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit
protocol SWPlayerItemDelegate {
    
    /// 已经更改了Rate
    /// - Parameters:
    ///   - type: 0 panRate 1 voluteRate
    ///   - rate: 相应的value
    func didChangeRate(_ type:Int,rate:Float,item:SWPlayerItemView)
}


class SWPlayerItemView: SWBaseView {

    var delegate:SWPlayerItemDelegate?
    
    let logoView = UIImageView()
    let panRate = UISlider()
    let panLabel = UILabel()
    
    let voluteRate = UISlider()
    let voluteLabel = UILabel()
    
    override func zjAddSubviews() {
        addSubview(logoView)
        panRate.tintColor = .red
        panRate.backgroundColor = .lightGray
        panRate.minimumValue = 0.5
        panRate.maximumValue = 1.5
        panRate.addTarget(self, action: #selector(panRage(sender:)), for: .valueChanged)
        addSubview(panRate)
        
        panLabel.textAlignment = .center
        panLabel.font = UIFont.systemFont(ofSize: 15)
        panLabel.text = "Pan"
        addSubview(panLabel)
        
        
        voluteRate.tintColor = .red
        voluteRate.backgroundColor = .lightGray
        voluteRate.minimumValue = 0.5
        voluteRate.maximumValue = 1.5
        voluteRate.addTarget(self, action: #selector(volumeRage(sender:)), for: .valueChanged)
        addSubview(voluteRate)
        
        voluteLabel.textAlignment = .center
        voluteLabel.font = UIFont.systemFont(ofSize: 15)
        voluteLabel.text = "Volume"
        addSubview(voluteLabel)
    }
    
    override func zjAddConstrints() {
        
        
        let gap = ScreenW / 3
        
        logoView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        panRate.snp.makeConstraints { (make) in
            make.left.equalTo(gap)
            make.width.equalTo(gap - 5)
            make.height.equalTo(20)
            make.bottom.equalTo(self.snp.centerY).offset(-10)
        }
        
        panLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.panRate)
            make.width.equalTo(gap - 5)
            make.height.equalTo(20)
            make.top.equalTo(self.snp.centerY).offset(10)
        }
        
        voluteRate.snp.makeConstraints { (make) in
            make.left.equalTo(gap * 2)
            make.width.equalTo(gap - 5)
            make.height.equalTo(20)
            make.bottom.equalTo(self.snp.centerY).offset(-10)
        }
        
        voluteLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.voluteRate)
            make.width.equalTo(gap - 5)
            make.top.equalTo(self.snp.centerY).offset(10)
        }
    }
    
    func setImage(_ name:String)  {
        logoView.image = UIImage.init(named: name)
    }
    
    @objc func panRage(sender:UISlider) {
        printLog("panRage\(sender.value)")
        callBack(type: 0, value: sender.value)
    }
    
    @objc func volumeRage(sender:UISlider) {
        printLog("volumeRage\(sender.value)")
        callBack(type: 1, value: sender.value)
    }
    
    
    /// 回调
    /// - Parameters:
    ///   - type: 类型
    ///   - value: value
    func callBack(type:Int,value:Float)  {
        self.delegate?.didChangeRate(type, rate: value,item: self)
    }
    
    
    

}
