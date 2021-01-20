//
//  SWAudioRecorderViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/19.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit
import AVFoundation

class SWAudioRecorderViewController: SWBaseViewController {
    
    let testFileName = "test.m4a"
    var recorder:AVAudioRecorder?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func recordering(_ sender:UIButton) {
        let  fileURL = URL.init(string: testFileName.documentFilePath)
        let  setting = [AVFormatIDKey:kAudioFormatMPEG4AAC,
                        AVSampleRateKey:22050.0,
                        AVNumberOfChannelsKey:1] as [String : Any]
        if recorder == nil {
            do {
                recorder = try AVAudioRecorder.init(url: fileURL!, settings: setting)
            } catch  {
                printLog("recorder error is:\(error)")
            }
        }
//      准备录制音频
//      该方法与AVPlayer 的prepareToPlay方法类似,这个方法执行底层Audio Queue初始化的必要过程.该方法还在URL参数指定的位置创建一个文件
//      讲录制启动时的延时降到最小.
        recorder?.prepareToRecord()
    }
    
    
    func initUI()  {
        self.title = "AVAudioRecorder"
        let string = "创建AVAudioRecorder实例时需要为其提供数据的一些信息,分别是:\n" +
        "* 用于表示音频写入文件的本地文件URL\n" +
        "*包含用于配置录音会话键信息的NSDictionary对象\n" +
        "*用于捕捉初始化阶段各种错误的NSError指针"
        setText(string)
    }
    
    
    /// 相关介绍说明
    func p_introduce()  {
        /* 1.音频格式
         
         kAudioFormatLinearPCM
         kAudioFormatMPEG4AAC
         kAudioFormatAppleLossless
         kAudioFormatAppleIMA4
         kAudioFormatLBC
         kAudioFormatULaw
         
         AVFormatIDKey 键定义了写入内容的音频格式,下面的常量都是音频格式所支持的值:
         指定kAudioFormatLinearPCM会将未压缩的音频流写入到文件中.这种格式的保真度最高,不过相应的文件也最大.
         选择诸如AAC(kAudioFormatMPEGAAC)或Apple IMA4(kAudioFormatAppleMA4)的压缩格式会显著缩小文件,
         还能保证高质量的音频内容.
         
         注意:你所指定的音频格式一定要和URL参数定义的文件类型兼容.比如:如果录制一个名为test.wav的文件,隐含的意思就是录制的音频
         必须满足Waveform Audio File Format(WAVE)的格式要求,即低字节序,Linear PCM.
         为AVFormatIDKey值指定除kAudioFormatLinearPCM之外的值会导致错误.查询NSError的LocalizedDescription会返回下面的错误信息:
         
         The operation couldn't be completed.(OSStatus error 1718449215)
         
         1718449215 错误状态是4字节编码的整数值,'fmt'意思是定义了一种不兼容的音频格式
         */
        
        /* 2.采样率
         AVSampleRateKey 用于定义录音器的采样率.采样率定义了对输入的模拟音频模拟信号每一秒内的采样数.
         在录制音频的质量及最终文件大小方面,采样率扮演着至关重要的角色.使用低采样率,比如8kHZ,会导致粗粒度,AM广播类型的录制效果,
         不过文件会比较小;使用44.1khz的采样率(CD质量的采样率)会得到非常高质量的内容,不过文件就比较大.对于使用什么采样率最好没有
         一个明确的定义,不过开发者应该尽量使用标准采样率,比如8000,160000,22050或44100.
         */
        
        /* 3.通道数
         AVNumberOfChannelsKey用于定义记录音频内容的通道数.指定默认值1意味着使用单声道录制,设置为2意味着使用立体声录制.
         除非使用外部硬件进行录制,否则通常应该创建单声道录音.
         */
        
        /* 4.指定格式的键
         处理Linear PCM或压缩音频格式时,可以定义一些其他指定格式的键.可以查阅相关文档,查看完整的列表.
         */
        
        /*2.控制录音过程
         创建了一个可用的录音器实例后,就可以开始录音了.AVAudioRecorder包含一些方法可以支持无限时长的录制,比如在未来某一时间点开始录制或
         录制指定时长的内容等.开发者甚至可以暂停录制并在之后从这个停止的地方继续重启录制.
         */
        
        /* 3.配置音频会话
         该应用的核心功能是录制并播放语音备忘录.我们知道不能使用默认的SoloAmbient分类(AVAudioSessionCategorySoloAmbient),因为该
         分类不支持音频输入.由于我们既需要录音又需要对外播放,那么合适的分类应该是AVAudioSessionCategoryPlayAndRecord.
         在Appdelegate中配置音频会话.
         
         */
    }
    
    
    lazy var recorderButton:UIButton = {
        weak var weakSelf = self
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("请开始录音", for: .normal)
        button.setTitle("停止录音",   for: .selected)
        button.layer.cornerRadius = 8.0
        button.addButtonEvent { (sender) in
            weakSelf?.recordering(sender)
        }
        return button
    }()
    
    
}
