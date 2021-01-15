//
//  SWAudioLooperViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/15.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWAudioLooperViewController: SWBaseViewController,SWPlayerItemDelegate {
    var button = UIButton()
    var rateSlider = UISlider()
    var rateLab = UILabel()
    var controller = THPlayerController()
    
    
    var images:[String] = ["guitar","bass","drum"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Audio Looper"
        initUI()
    }
    
    
    
    func initUI()  {
        weak var weakSelf = self
        for itemView in items {
            self.view.addSubview(itemView)
            self.view.bringSubviewToFront(itemView)
        }
        
        button.isSelected = controller.isPlaying
        button.setTitle("Play", for: .normal)
        button.setTitle("Stop", for: .selected)
        button.backgroundColor = .red
        button.addButtonEvent { (sender) in
            weakSelf?.changeState(sender: sender)
        }
        self.view.addSubview(button)
        
        rateSlider.tintColor = .red
        rateSlider.backgroundColor = .lightGray
        rateSlider.minimumValue = 0.5
        rateSlider.maximumValue = 2.0
        rateSlider.addTarget(self, action: #selector(allRate(sender:)), for: .valueChanged)
        self.view.addSubview(rateSlider)
        
        rateLab.textAlignment = .center
        rateLab.font = UIFont.systemFont(ofSize: 15)
        rateLab.text = "Rate"
        self.view.addSubview(rateLab)
        
        button.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.bottom.equalToSuperview().offset(-50)
            make.size.equalTo((CGSize(width: 100, height: 40)))
        }
        
        rateSlider.snp.makeConstraints { (make) in
            make.left.equalTo(self.button.snp.right).offset(50)
            make.right.equalTo(-10)
            make.height.equalTo(40)
            make.centerY.equalTo(button)
        }
        rateLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.button.snp.right).offset(50)
            make.right.equalTo(-10)
            make.height.equalTo(40)
            make.top.equalTo(rateSlider.snp.bottom).offset(10)
        }
        
        
    }
    
    @objc func allRate(sender:UISlider) {
        self.controller.adjust(rate: sender.value)
    }
    
    func changeState(sender:UIButton)  {
        if self.controller.isPlaying {
            self.controller.stop()
        } else {
            self.controller.play()
        }
        sender.isSelected = !sender.isSelected
    }
    
    // MARK: - SWPlayerItemDelegate
    func didChangeRate(_ type: Int, rate: Float, item: SWPlayerItemView) {
        //小提琴
        if item == items[0] {
            //pan rate
            if type == 0 {
                self.controller.adjustPan(rate, at: 0)
            }
            //volume rate
            else if type == 1 {
                self.controller.adjustVolume(rate, at: 0)
            }
        }
        //钢琴
        else if item == items[1] {
            //pan rate
            if type == 0 {
                self.controller.adjustPan(rate, at: 1)
            }
            //volume rate
            else if type == 1 {
                self.controller.adjustVolume(rate, at: 1)
            }
        }
        //鼓
        else if item == items[2] {
            //pan rate
            if type == 0 {
                self.controller.adjustPan(rate, at: 2)
            }
            //volume rate
            else if type == 1 {
                self.controller.adjustVolume(rate, at: 2)
            }
        }
    }
    
    
    
    lazy var items:[SWPlayerItemView] = {
        let width  = ScreenW / 3
        let height = 100.0
        let topY  = self.navBarHeight + 20
        var result = [SWPlayerItemView]()
        for (index,value) in images.enumerated() {
            let gap = height * Double(index)
            let frame = CGRect(x: 0, y: topY + CGFloat(gap), width: ScreenW, height: CGFloat(height))
            let itemView = SWPlayerItemView.init(frame: frame)
            itemView.delegate = self
            itemView.setImage(value)
            result.append(itemView)
        }
        return result
    }()

    
    

}
