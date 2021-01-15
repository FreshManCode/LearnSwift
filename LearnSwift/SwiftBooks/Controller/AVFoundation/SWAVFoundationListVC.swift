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
