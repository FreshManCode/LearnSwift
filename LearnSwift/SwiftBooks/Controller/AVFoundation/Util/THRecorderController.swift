//
//  THRecorderController.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/20.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit
import AVFoundation

protocol THRecorderControllerDelegate {
     func interruptionBegan()
}

class THRecorderController: NSObject,AVAudioRecorderDelegate {
    
    /* THRecorderController 类中采用AVAudioRecorderDelegate协议.录音器的委托协议定义了一个方法,
     当录制完成时会发送一个通知.所以得到录制过程中的信息非常重要,这样才能让用户为这段录音命名并保存起来.
     
     */
    
    typealias RecordStopCompletion = (Bool)->()
    typealias RecordSaveCompletion = (Bool,Any)->()
    
    var recorder:AVAudioRecorder?
    var completionHandler:RecordStopCompletion?
    var player:AVAudioPlayer?
    var delegate:THRecorderControllerDelegate?
    var meterTable:SWMeterTable?
    
    /// 注意:要把该settings 中对应的值转换成NSNumber,否则会无法录制
    let settings:[String:Any] = [
        AVFormatIDKey:NSNumber(value: kAudioFormatAppleIMA4),
        AVSampleRateKey:NSNumber(value: 44100.0),
        AVNumberOfChannelsKey:NSNumber(value: 1),
        AVEncoderBitDepthHintKey:NSNumber(value: 16),
        AVEncoderAudioQualityKey:NSNumber(value: AVAudioQuality.medium.rawValue)]
    
    override init() {
        super.init()
        config()
    }
    
    func config()  {
        /*  记录到一个名为memo.caf的文件,在录制音频的过程中,Core Audio Format(CAF)通常是最好的容器格式,因为它和内容无关
         并可以保存Core Audio支持的任何音频格式.
         */
        let filePath = "memo.caf".temporaryFilePath
        let fileURL = URL.init(fileURLWithPath: filePath)
        
        do {
            self.recorder = try AVAudioRecorder.init(url: fileURL, settings: settings)
        } catch  {
            printLog("error is:\(error)")
        }
        if self.recorder != nil {
            self.recorder!.delegate = self
            self.recorder!.isMeteringEnabled = true;
            self.recorder!.prepareToRecord()
        } else {
            printLog("recorder is nil")
        }
        self.meterTable = SWMeterTable()
    }
    
    
    
    // MARK: - public
    func record() -> Bool? {
        let result = self.recorder?.record()
        printLog("record result:\(result)")
        return result
    }
    
    func pause()  {
        recorder?.pause()
    }
    
    func stopCompletionHandler(_ handler:@escaping RecordStopCompletion)  {
        self.completionHandler = handler
        recorder?.stop()
    }
    
    func saveRecording(with name:String,completion handler:RecordSaveCompletion)  {
        /*
         当用户停止录音,进入对语音备忘命名阶段时,试图控制器会调用saveRecording(with name:completion handler:)方法
         该方法通过唯一文件名将tmp目录中的录制文件复制到Documents目录.如果复制操作成功,会调用完成块,传递回一个新的包含名字
         和录制音频URL的THMemo实例
         */
        let timeStmp = NSDate.timeIntervalSinceReferenceDate
        let fileName = String.localizedStringWithFormat("%@-%f.caf",name,timeStmp)
        let destPath = fileName.documentFilePath
        let srcURL = recorder?.url
        guard let _ = srcURL else {
            printLog("srcURL is nil")
            return
        }
        let destinationURL = URL.init(fileURLWithPath: destPath)
        printLog("srcURL is:\(srcURL!) destinationURL is\(destinationURL)")
        do {
            try FileManager.default.copyItem(at: srcURL!, to: destinationURL)
            handler(true,THMemo.memo(with: name, url: destinationURL))
        } catch  {
            handler(false,error)
            printLog("error:\(error)")
        }
    }
    
    func levels() -> SWLevelPair {
        self.recorder?.updateMeters()
        let avgPower = (self.recorder?.averagePower(forChannel: 0))
        let peakPower = self.recorder?.peakPower(forChannel: 0)
        let linearLevel = self.meterTable?.valueForPower(avgPower!)
        let linearPeak = self.meterTable?.valueForPower(peakPower!)
        return SWLevelPair(level: linearLevel, peakLevel: linearPeak)
        
    }
    
    
    /// 播放录制的内容
    /// - Parameter memo: 录制的item
    /// - Returns: 是否播放成功
    func playBackMemo(_ memo:THMemo) -> Bool {
        /* 播放功能做好后,最后一个尚未完成的功能就是展示播放时间.用户界面上有一个标签用于展示时间,不过现在这个标签始终显示00:00:00
         还是无法令人信服的功能.AVAudioRecorder 具有的currentTimer属性可以简单地构建一个用户界面,为用户提供时间反馈信息.该属性返回
         一个NSTimeInterval,用于指示从录制开始到现在的时间,以s来计算.NSTimeInterval不适合在用户界面上展示,我们可以通过一些处理
         让其能够美观地展示.如下:formattedCurrentTime方法
         
         */
        guard var myURL = memo.url else { return false }
        myURL = URL.init(fileURLWithPath: myURL.path)
        self.player?.stop()
        do {
            self.player = try AVAudioPlayer.init(contentsOf: myURL)
        } catch  {
            printLog("playBackMemo error is:\(error)")
        }
        if self.player != nil {
            self.player?.play()
            return true
        }
        return false
    }
    
    
    /// 暂停播放录音
    /// - Parameter memo: 对应的Item
    /// - Returns: YES/NO
    func pauseMemo(_ memo:THMemo) -> Bool {
        if self.player?.isPlaying == true {
            self.player?.pause()
            return true
        }
        return false
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if let completionHandler = self.completionHandler {
            completionHandler(true)
        }
    }
    
    func audioRecorderBeginInterruption(_ recorder: AVAudioRecorder) {
        self.delegate?.interruptionBegan()
    }
    
    
    
    /// 格式化时间显示
    var formattedCurrentTime: String  {
        guard let myRecorder = self.recorder else {
            printLog("formattedCurrentTime error")
            return "00:00:00" }
        let time = Int(myRecorder.currentTime)
        let hours = time / 3600
        let minutes = (time / 60) % 60
        let seconds = time % 60
        return String.localizedStringWithFormat("%02i:%02i:%02i", hours,minutes,seconds)
    }
    
    
    
}
