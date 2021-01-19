//
//  SWAVFoundationListVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/13.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit
import AVFoundation

class SWAVFoundationListVC: SWBaseViewController {
    
    

    var sectionsArray:[SWAVfounfationSectionModel] = SWAVfounfationSectionModel.defaultData()
    ///播报类型
    var voices = [AVSpeechSynthesisVoice.init(language: "zh-Hans"),
                  AVSpeechSynthesisVoice.init(language: "en-us")]
    var mySynthesizer = AVSpeechSynthesizer()
    
    var player:AVAudioPlayer?
    
    
    
    override func viewDidLoad() {
        self.title = "AVFoundation章节"
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(SWAVFoundationReuseHeaderView.classForCoder(),
                           forHeaderFooterViewReuseIdentifier: SWAVFoundationReuseHeaderView.CID())
        tableView.reloadData()
        printLocalLanguage()
    }
    
    
    private func printLocalLanguage () {
        printLog(Locale.availableIdentifiers)
    }
    
    // MARK: - AVSpeechUtterance简单语音播放播放
    @objc func simpleAVSpeechUtterance () {
        let synthesizer = AVSpeechSynthesizer()
        let utterAnce = AVSpeechUtterance.init(string: "Hello wordl!")
        synthesizer.speak(utterAnce)
//      该代码进行简单的语音播报
    }
    
    // MARK: - 中文语音播报
    @objc func simpleChineseRadio () {
//      如果给中文,则以中文方式播报,如果给英文则播放英文
        let utterance = AVSpeechUtterance.init(string: "大家好跑")
//      设置播放的语种
        utterance.voice = self.voices[0]
        utterance.rate = 0.4
        utterance.pitchMultiplier = 0.8
//      如果是多段播放,在播放完毕时停顿的短暂时间
        utterance.postUtteranceDelay = 0.1
        self.mySynthesizer.speak(utterance)
//      该代码进行简单的语音播报
    }
    
    // MARK: - 英文播通知
    @objc func simpleEnglishRadio () {
        /// 只读取英文部分,中文部分不显示
        let utterance = AVSpeechUtterance.init(string: "中国好Good")
        utterance.voice = self.voices[1]
        utterance.rate = 0.40
        utterance.pitchMultiplier = 0.8
        utterance.postUtteranceDelay = 0.1
        self.mySynthesizer.speak(utterance)
//      该代码进行简单的语音播报
    }
    
    // MARK: - section2
    @objc func aboutAudioSession() {
        let  string = "音频会话在应用程序和操作系统之间扮演着中间人的角色.它提供了一种简单实际的方法使OS得知应用程序应该如何与iOS音频进行交互.\n\n" +
            "所有iOS应用程序都具有音频会话,无论其是否使用.默认音频会话来自以下一些预配置" +
        "\n *激活了音频播放,但是音频录制未激活" +
        "\n *当用户切换响铃/静音开关到\"静音\"模式时,应用程序播放所有的音频都会消失" +
        "\n *当设置显示解锁屏幕时,应用程序的音频处于静音状态" +
        "\n *当应用程序播放音频时,所有后台播放的音频都会处于静音状态"
        setText(string)
    }

    
    // MARK: - 使用AVAudioPlayer播放音频
    @objc func playerVoiceWithAvAudioPlayer () {
        //1.创建AVAudioPlayer ,一共两种方法,一种是播放音频的内存版本的NSData,或者本地音频文件NSURL.
        //如果是iOS系统,URL必须是在应用程序沙盒之内
        let fileURL = Bundle.main.url(forResource: "泡沫", withExtension: "mp3")
        guard let myFileURL = fileURL else { return  }
        do {
             player = try AVAudioPlayer.init(contentsOf: myFileURL)
        } catch  {
            printLog("Error is:",error)
        }
//prepareToPlay 方法会取得苏需要的音频硬件并预加载Audio Queue的缓存区.
        player?.prepareToPlay()
        player?.play()
        
        /**
         1.play 方法可以实现立即播放音频的功能,pause方法可以对播放暂停,那么可想而知stop方法可以停止播放行为.
         2.调用pause和stop方法停止播放的音频都会继续播放,这两者最主要的区别在底层处理上.调用stop方法会撤销prepareToPlay时所做的设置,
         而调用pause方法则不会
         
         除了常规方法之外,还可以使用其他一些有趣的方法,如下所示:
         *修改播放器的音量:比如渐隐效果
         *修改播放器的pan值:允许使用立体声播放声音.
         *调整播放率:(范围从0.5倍速到2.0倍速)
         *通过设置numberOfLoops属性实现音频无缝循环.
         
         音频播放可以是未压缩的PCM音频,也可以是AAC之类的压缩格式视频
         
         *进行音频计量:当播放发生时从播放器读取音量力度的平均值及峰值.可将这些数据提供给VU计量器或其他可视化原件,
         向用户提供可视化的反馈效果
         */
    }
    
    // MARK: - 创建Audio Looper
    @objc func createAudioLooper()  {
        self.navigationController?.pushViewController(SWAudioLooperViewController(), animated: true)
    }
    
    // MARK: - 4.配置音频会话
    @objc func configAudioSession () {
        /* 所有iOS应用程序都自动带有一个默认音频会话,分类名称为Solo Ambient.这个类型可以播放音频,但对于一个主要功能为播放的应用
         程序来说并不合适.由于默认分类不能提供我们期望的功能,需要对音频会话进行更明确的配置.音频会话通常会在应用程序启动时进行一次配置,
         所以可将配置代码写在AppDelegate中.
         */
    }
    
    // MARK: - 5.处理中断事件
    @objc  func handleInterruptionEvent()  {
        /*
         中断在iOS设备中经常出现,在使用设备的过程中经常会有电话呼入,闹钟响起及弹出FaceTime等情况.虽然iOS系统本身可以很好地处理这些事件,
         不过我们还是要确保自己针对这些情况处理的够完美.
         
         音频会话通知:
         在准备出现的中断事件采取动作前,首先需要得到中断出现的通知,注册应用程序的AVAudioSession发送的通知
         AVAudioSessionInterruptionNotification.在控制器的init方法中注册该通知.
         
         推送的通知会包含一个带有多许多重要信息的userInfo字典,根据这个字典可以确定采取哪些合适的操作.
         在处理的方法中 根据 AVAudioSessionInterruptionTypeKey 的值确定中断的类型.返回值是AVAudioSessionInterruptionType
         ,这是用于表示中断开始或者结束的枚举类型.
         */
    }
    
    // MARK: - 6.对线路改变的响应
    @objc func respondToChangeLine() {
        /* 在iOS设备上添加或者移除音频输入,输出线路时,会发生线路改变.有多重原因会导致线路的变化,比如用户插入耳机或断开USB麦克风.当
         这些事件发生时,音频会根据情况改变输入或输出线路,同时AVAudioSession会广播一个描述该变化的通知给所有相关的侦听器.
         
         下面对音频播放做个测试,在播放期间插入耳机.音频输出线路变为耳机插孔并继续正常播放,这就是所要的效果.保持音频处于播放状态,断开耳机
         连接.音频线路再次回到设备的内置扬声器,我们再次听到了声音.
         当线路变化时,有相关的通知.我们首先注册AVAudioSession发送的通知,该通知名为AVAudioSessionRouteChangeNotification.该
         通知包含一个userinfo字典,该字典带有相应通知发送的原因信息及前一个线路的描述,这样我们就可以确定线路变化的情况了.
         
         收到通知后第一件事情就是判断线路发生变更的原因.查看保存在userinfo字典中表示原因的AVAudioSessionRouteChangeReasonKey的值
         这个返回值是一个用于表示变化原因的无符号整数.通过原因推断出不同的事件.
         
         知道有设备断开连接后,从userinfo字典中获取用于描述前一个线路的AVAudioSessionRouteDescription.线路的描述信息整合在一个
         输入NSArray 和一个输入NSArray中.数组中的元素都是AVAudioSessionPortDescription的实例,用于描述不同的I/O接口属性.
         在本例中,需要从线路描述中找到第一个输出接口并判断是否为耳机接口.如果是,则停止播放.并传递相应的状态.
         
         THPlayerController 类中对拔出耳机做出了相应的处理.具体可以查看相应class
         */
    }
    
    // MARK: - 7.使用AVAudioRecorder录制音频
    @objc func useAVAudioRecorder() {
        self.navigationController?.pushViewController(SWAudioRecorderViewController(), animated: true)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = sectionsArray[section]
        return sectionModel.rows?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let reuseView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SWAVFoundationReuseHeaderView.CID()) as? SWAVFoundationReuseHeaderView
        reuseView?.setTitle(sectionsArray[section].name ?? "")
        return reuseView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = sectionsArray[indexPath.section]
        let rowModel = sectionModel.rows?[indexPath.row]
        return SWDifferentCell.cellWithTableView(text: rowModel?.name ?? "DefaultName", tableView: tableView);
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionModel = sectionsArray[indexPath.section]
        let rowModel = sectionModel.rows?[indexPath.row]
        var text = ""
        guard let model = rowModel else { return  }
        text = model.selName ?? "";
        let aSelector  = NSSelectorFromString(text)
        if self.responds(to: aSelector) {
            self.perform(aSelector);
        }
    }
    
    
    
    
    
    
    
    
    
    

}
