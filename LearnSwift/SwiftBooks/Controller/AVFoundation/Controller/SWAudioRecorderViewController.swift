//
//  SWAudioRecorderViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/19.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWAudioRecorderViewController: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    
    func initUI()  {
        self.title = "AVAudioRecorder"
        let string = "创建AVAudioRecorder实例时需要为其提供数据的一些信息,分别是:\n" +
        "* 用于表示音频写入文件的本地文件URL\n" +
        "*包含用于配置录音会话键信息的NSDictionary对象\n" +
        "*用于捕捉初始化阶段各种错误的NSError指针"
        setText(string)
    }
    
}
