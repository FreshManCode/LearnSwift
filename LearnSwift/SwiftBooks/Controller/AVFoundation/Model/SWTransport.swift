//
//  SWTransport.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/27.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import Foundation

@objc protocol SWTransportDelegate {
    func play()
    func pause()
    func stop()
    
    func scrubbingDidStart()
    func scrubbedToTime(time:TimeInterval)
    func scrubbingDidEnd()
    
    func jumpedToTime(time:TimeInterval)
    
    @objc optional func subtitleSelected(subTittle:String)
    
}

protocol SWTransport {
    
    var delegate:SWTransportDelegate? { get set }
    
    func setTitle(_ title:String)
    
    func setCurrentTime(_ time:TimeInterval,duration:TimeInterval)
    
    func setScrubbingTime(_ time:TimeInterval)
    
    func playbackComplete()
    
    func setSubtitles(_ subtitles:[String])
    
    
    
}
