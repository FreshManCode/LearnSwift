//
//  THPlayerController.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/15.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import Foundation
import AVFoundation

struct THPlayerController {
    
    private var playing:Bool = false
    var isPlaying:Bool {
        get {
            playing
        }
    }
    var players = [AVAudioPlayer?]()
    
    init() {
        let guitarPlayer = playerForFile("guitar")
        let basePlayer = playerForFile("base")
        let drumsPlayer = playerForFile("drums")
        players.append(guitarPlayer)
        players.append(basePlayer)
        players.append(drumsPlayer)
    }
    
    

    mutating func play()  {
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
    
    mutating func stop()  {
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
}
