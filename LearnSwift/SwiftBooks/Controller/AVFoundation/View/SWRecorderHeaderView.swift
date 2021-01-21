//
//  SWRecorderHeaderView.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/21.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

let DefaultText = "00:00:00"


enum SWRecorderType:Int {
    ///开始录音
    case start
    ///暂停录音
    case pause
    ///停止录音
    case stop
}

protocol SWRecorderHeaderViewDelegate {
    
    /// 录音状态发生相关变化
    /// - Parameters:
    ///   - recorderView: view
    ///   - recorderType: 状态
    func recorderViewDidChangeStatus(_ recorderView:SWRecorderHeaderView,_ recorderType:SWRecorderType)
}

class SWRecorderHeaderView: SWBaseView {

    var timeLabel  = UILabel()
    var playButton = UIButton()
    var stopButton = UIButton()
    var delegate:SWRecorderHeaderViewDelegate?
    
    
    override func zjAddSubviews() {
        timeLabel.textColor = .white
        timeLabel.textAlignment = .center
        timeLabel.text  = DefaultText
        timeLabel.font = .systemFont(ofSize: 15)
        
        playButton.setImage("play".myImage, for: .normal)
        playButton.setImage("pause".myImage, for: .selected)
        stopButton.setImage("stop".myImage, for: .normal)
        stopButton.isEnabled = false
        
        addSubview(timeLabel)
        addSubview(playButton)
        addSubview(stopButton)
        
        weak var weakSelf = self
        playButton.addButtonEvent { (sender) in
            sender.isSelected = !sender.isSelected
            weakSelf?.callBack(type: sender.isSelected ? SWRecorderType.start:SWRecorderType.pause )
            weakSelf?.stopButton.isEnabled = sender.isSelected
        }
        stopButton.addButtonEvent { (sender) in
            weakSelf?.callBack(type: .stop)
        }
    }
    
    
    override func zjAddConstrints() {
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        playButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.centerX).offset(-20)
            make.top.equalTo(self.timeLabel.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        stopButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.centerX).offset(20)
            make.top.equalTo(self.timeLabel.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
    }
    
    
    func callBack(type:SWRecorderType)  {
        self.delegate?.recorderViewDidChangeStatus(self, type)
    }
    
    
    func updateTimeText(_ message:String)  {
        printLog("message:\(message)")
        self.timeLabel.text = message
    }
    
    
    

}
