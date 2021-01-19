//
//  THPlayerController.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/15.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import Foundation
import AVFoundation

protocol THPlayerControllerDelegate {
    
    /// 播放状态已经变化
    /// - Parameter isStoped: 是否是停止
    func playBackDidChangeState(isStoped:Bool)
}

class THPlayerController:NSObject {
    
    public var delegate:THPlayerControllerDelegate?
    
    private var playing:Bool = false
    var isPlaying:Bool {
        get {
            playing
        }
    }
    var players = [AVAudioPlayer?]()
    
    override init() {
        super.init()
//      中断通知
        regiserInterrpuitonNotification()
//      线路更改通知
        registerChangeRouteNotification()
        let guitarPlayer = playerForFile("guitar")
        let basePlayer = playerForFile("base")
        let drumsPlayer = playerForFile("drums")
        players.append(guitarPlayer)
        players.append(basePlayer)
        players.append(drumsPlayer)
        
    }
    
    /// 注册中断通知
    private func regiserInterrpuitonNotification () {
        weak var weakSelf = self
        self.addNoti(notiName: AVAudioSession.interruptionNotification,
                       object: AVAudioSession.sharedInstance()) { (sender) in
            weakSelf?.receiveInterruption(sender)
        }
    }
    
    /// 收到了音频中断的通知
    /// - Parameter notification: 通知
    @objc func receiveInterruption(_ notification:Notification) {
        guard let userInfo = notification.userInfo else { return  }
        printLog("userInfo:\(userInfo)")
        let type = userInfo[AVAudioSessionInterruptionTypeKey] as? Int
        printLog("type:\(type)")
        guard let MyType = type else { return}
        
        //当出现中断时,需要采取的一个动作就是正确更新Play/Stop按钮的状态及相关的标签.该Class不对用户界面进行管理,需要一个方法
        //把这些中断事件通知给试图控制器.
        
        if MyType == AVAudioSession.InterruptionType.began.rawValue {
            //          调用stop方法,并且通过委托调用函数的playBackDidChangeState方法通知中断状态
            stop()
            self.delegate?.playBackDidChangeState(isStoped: true)
            printLog("中断开始了")
        }
        //如果中断类型为AVAudioSession.InterruptionType.ended,userInfo字典会包含一个AVAudioSessionInterruptionOptions
        //值来表明音频会话是否已经重新激活以及是否可以再次播放
        
        else  {
            let options = userInfo[AVAudioSessionInterruptionOptionKey] as? Int
            guard let myOptions = options else { return  }
            if myOptions == AVAudioSession.InterruptionOptions.shouldResume.rawValue {
                ////重新启动
                play()
                self.delegate?.playBackDidChangeState(isStoped: false)
            }
        }
    }
    
    
    /// 注册更换输出线路通知(耳机/扬声器 切换)
    private func registerChangeRouteNotification() {
        weak var weakSelf = self
        self.addNoti(notiName: AVAudioSession.routeChangeNotification,
                       object: AVAudioSession.sharedInstance()) { (notification) in
            weakSelf?.receiveInterruption(notification)
        }
    }
    
    /// 收到更换输出线路的通知
    /// - Parameter notification: 通知
    private func receiveChangeRouteNotification (_ notification:Notification) {
        guard let userInfo = notification.userInfo else { return  }
        let reason = userInfo[AVAudioSessionRouteChangeReasonKey] as? Int
        guard let myReason = reason else { return  }
        
//      设备断开连接
        if myReason == AVAudioSession.RouteChangeReason.oldDeviceUnavailable.rawValue {
            let previousRoute = userInfo[AVAudioSessionRouteChangePreviousRouteKey] as? AVAudioSessionRouteDescription
            guard let myPreviousRoute = previousRoute else { return  }
            let previousOutPut = myPreviousRoute.outputs[0]
            let portType = previousOutPut.portType
            //如果前一个线路信息是耳机
            if portType == AVAudioSession.Port.headphones {
                //在拔出耳机时,停止播放音频
                stop()
                delegate?.playBackDidChangeState(isStoped: true)
            }
            
            
            
            
            
        }
        
        
    }
    

    func play()  {
        if !playing {
            let delayTime = self.players[0]?.deviceCurrentTime ?? 0.01 + 0.01
            for player in players {
                player?.play(atTime: delayTime)
            }
            playing = true
        }
        //      要对三个播放器实例的播放进行同步,需要捕捉当前设备时间并添加一个小延时,这样就会具有一个从开始播放时间计算的参照时间.
        //      通过对每个实例调用play(atTime:)方法并传递延时参照时间,遍历播放器数组并开始播放.这样就保证了这些播放器在音频播放时始终
        //      保持紧密同步.下面继续stop过程
    }
    
    func stop()  {
        if playing {
            for player in players {
                player?.stop()
                player?.currentTime = 0.0
            }
            playing = false
        }
        //      该方法很直接,如果音频正在播放,遍历播放器数组并对每一个对象调用stop方法.开发者可能还需要设置每个播放的currentTime属性为0.0,
        //      这样做会让播放器进度回到音频文件的原点.最终你需要更新playing状态来指明播放已经停止.
    }
    
    
    /// 调整播放速度
    /// - Parameter rate: 0.5-1.5
    func adjust(rate:Float)  {
        for player in players {
            player?.rate = rate
        }
    }
    
    func adjustPan(_ pan:Float,at index:Int)  {
        if isValidIndex(index) {
            players[index]?.pan = pan
        }
    }
    
    func adjustVolume(_ volume:Float,at index:Int)  {
        if isValidIndex(index) {
            players[index]?.volume = volume
        }
    }
    
    func playerForFile(_ fileName:String) -> AVAudioPlayer? {
        let fileURL = Bundle.main.url(forResource: fileName, withExtension: "caf")
        guard let myURL = fileURL else { return nil  }
        var player : AVAudioPlayer?
        do {
            player = try AVAudioPlayer.init(contentsOf: myURL)
            player!.numberOfLoops = -1
            player!.enableRate = true
            player!.prepareToPlay()
        } catch  {
            printLog("error is:",error)
        }
        return player
    }
    
    func isValidIndex(_ index:Int) -> Bool {
        return index == 0 || index < players.count
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
        stop()
        self.delegate?.playBackDidChangeState(isStoped: true)
    }
}
