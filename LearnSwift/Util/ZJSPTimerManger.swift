//
//  ZJSPTimerManger.swift
//  SinaPayApp
//
//  Created by 张君君 on 2021/1/4.
//  Copyright © 2021 com.sinapay. All rights reserved.
//

import UIKit

protocol ZJSPTimerMangerDelegate {
    
    /// 定时器已经更新
    /// - Parameters:
    ///   - manager: 定时器对象
    ///   - remainTime: 剩余时间
    func timerMangerDidUpdate(manager:ZJSPTimerManger,remainTime:CGFloat)
}


class ZJSPTimerManger: NSObject {
    
    var delegate:ZJSPTimerMangerDelegate?
    var timer:Timer?
    var remainTime:Int?
    
    
    var maxTime:Int? {
        didSet {
            remainTime = maxTime
        }
    }
    var timeGap:CGFloat? {
        didSet {
            changeTimeGap()
        }
    }
    
    static let manager = ZJSPTimerManger()
    
    class func timer(maxTime:Int,timeGap:CGFloat) -> ZJSPTimerManger {
        let timeManger = ZJSPTimerManger()
        timeManger.maxTime = maxTime
        timeManger.timeGap = timeGap
        return timeManger
    }
    
    @objc func timeCountDown(timer:Timer)  {
        remainTime! -= 1
        if remainTime! <= 0 {
            remainTime = 0
        }
        delegate?.timerMangerDidUpdate(manager: self, remainTime: CGFloat(remainTime!))
    }
    
    override init() {
        super.init()
        defaultInit(timeGap: 1)
    }
    
    func defaultInit(timeGap:TimeInterval)  {
        let interVal = timeGap > 0 ? timeGap : 1
        self.timeGap = CGFloat(interVal)
        changeTimeGap()
    }
    
    func changeTimeGap()  {
        resetTimer()
        self.timer = myTimer
    }
    
    
    
    func timerFire()  {
        if self.timer == nil {
            self.timer = myTimer
        }
        self.timer?.fireDate = Date.distantPast
        RunLoop.current.add(timer!, forMode: .common)
        delegate?.timerMangerDidUpdate(manager: self, remainTime: CGFloat(remainTime!))
    }
    
    func resetTimer()  {
        if let timer = self.timer {
            timer.fireDate = Date.distantFuture
            timer.invalidate()
            self.timer = nil
        }
    }
    
    private var myTimer:Timer? {
        
        let tempTimer = Timer.scheduledTimer(timeInterval: Double(timeGap!),
                                             target: self,
                                             selector: #selector(timeCountDown(timer:)),
                                             userInfo: nil,
                                             repeats: true)
        return tempTimer
    }
    
    
    
    
}
