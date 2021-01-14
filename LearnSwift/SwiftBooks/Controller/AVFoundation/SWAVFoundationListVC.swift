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
