//
//  ZJSPNotiCallBackHolder.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/2/4.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

public typealias NotificationEvent = (Notification)->()

class ZJSPNotiCallBackHolder: NSObject {

    static let share = ZJSPNotiCallBackHolder()
    var NotificationEvent:NotificationEvent?
    var currentNotiName:Notification.Name?
    var notiNameS:[String]=[]
    
    
    func my_addNotification(name:String,
                            object:Any?,
                            _ callBack : @escaping NotificationEvent) {
        my_addNoti(notiName: name.NotificationName, object: object, callBack)
    }
    
    func my_addNoti(notiName:Notification.Name,
                    object:Any?,
                    _ callBack : @escaping NotificationEvent)  {
        notiNameS.append(notiName.rawValue)
        self.NotificationEvent = callBack
        self.currentNotiName   = notiName
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(myNotiEvent(sender:)),
                                               name: notiName,
                                               object: object)
    }
    
    func my_remove(name:String,object:Any?)  {
        my_removeObserver(notiName: name.NotificationName, object: object)
    }
    
    func my_removeObserver(notiName:Notification.Name,object:Any?)  {
        let notiNameStr = notiName.rawValue
        if notiNameS.contains(notiNameStr) {
            NotificationCenter.default.removeObserver(self, name: notiName, object: object)
        }
    }
    
    @objc private func myNotiEvent(sender:Notification)  {
        printLog("myNotiEvent:\(sender)")
        let holer = ZJSPNotiCallBackHolder.share
        if let CallBack = holer.NotificationEvent {
            CallBack(sender)
        }
    }
}
