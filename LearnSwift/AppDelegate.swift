//
//  AppDelegate.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/5/25.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit
import AVFoundation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var MainTab: SWMainTabBarViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let _ = ZJSPNotiCallBackHolder.share
        
//      初始化复用池
        let _ = ZJWebViewPool.shared
        
        
        configureAudioSession()
        
        window = UIWindow.init(frame: UIScreen.main.bounds);
        window?.backgroundColor = UIColor.white;
        
        MainTab = SWMainTabBarViewController();
        window?.rootViewController = MainTab;
        window?.makeKeyAndVisible();
        // Override point for customization after application launch.
        return true
    }
    
    
    /// 配置音频会话
    func configureAudioSession()  {
        let session = AVAudioSession.sharedInstance()
        
//      仅仅可以播放
        var category = AVAudioSession.Category.playback
//      既可以录制又可以播放
        category = .playAndRecord
        do {
//          当音频会话配置完毕之后,重新在设备上部署应用程序并运行测试.此时,切换"铃音/静音"开关不能让声音消失
            try session.setCategory(category)
            try session.setActive(true, options: [])
        } catch  {
            printLog("configureAudioSession Error:\(error)")
        }
        /* 设置成 AVAudioSession.Category.playback 分类可以让应用程序在后台播放音频.这是设备锁定时所处的状态,但是我们仍需要对应用
         程序的Info.plist文件进行细微修改来实现这个功能.
         添加一个新的Required background modes类型数组,在其中添加名为App plays audio or streams audio/video using
         Airplay 的选项. 添加这一设置表示应用程序允许在后台播放音频内容.再次编译并部署应用程序,再次播放.现在如果按下设备上的Lock按钮.可以
         听到音频仍然可以从后台播放
         
         */
        
        weak var weakSelf = self
        self.addNoti(notiName: AVAudioSession.interruptionNotification,
                     object: AVAudioSession.sharedInstance()) { (sender) in
            weakSelf?.receiveNoti(sender: sender)
        }
    }
    
    func receiveNoti(sender:Notification)  {
        printLog("receiveNoti:\(sender)")
    }

    // MARK: UISceneSession Lifecycle

//    @available(iOS 13.0, *)
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    @available(iOS 13.0, *)
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}

