//
//  SWAVFoundationListVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/13.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit
import AVFoundation
import AssetsLibrary
import MediaPlayer

class SWAVFoundationListVC: SWBaseViewController {
    
    

    var sectionsArray:[SWAVfounfationSectionModel] = []
    ///播报类型
    var voices = [AVSpeechSynthesisVoice.init(language: "zh-Hans"),
                  AVSpeechSynthesisVoice.init(language: "en-us")]
    var mySynthesizer = AVSpeechSynthesizer()
    
    var player:AVAudioPlayer?
    
    var avPlayer:AVPlayer? 
    
    
    
    
    override func viewDidLoad() {
        self.title = "AVFoundation章节"
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(SWAVFoundationReuseHeaderView.classForCoder(),
                           forHeaderFooterViewReuseIdentifier: SWAVFoundationReuseHeaderView.CID())
        configDefaultData()
        
        //        printLocalLanguage()
    }
    
    func configDefaultData()  {
        showLoading()
        weak var weakSelf = self
        dispatchAsync {
            weakSelf!.sectionsArray =  SWAVfounfationSectionModel.defaultData()
            weakSelf!.dispatchAfter(0.5) {
                weakSelf!.myReloadData()
            }
        }
    }
    
    func myReloadData()  {
        tableView.reloadData()
        hideLoading()
    }

    private func printLocalLanguage () {
        printLog(Locale.availableIdentifiers)
    }
    

    
    // MARK: - Tableview

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
