//
//  SWAvfoundationModel.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/14.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import Foundation

struct SWAVfounfationSectionModel {
    var name:String?
    var rows:[SWAVfounfationRowModel]?
}

struct SWAVfounfationRowModel {
    var name:String?
    var selName:String?
}

extension SWAVfounfationSectionModel {
    static func defaultData() -> [SWAVfounfationSectionModel] {
        var result = [SWAVfounfationSectionModel]()
        for index in 0 ..< 2 {
            var sectionModel = SWAVfounfationSectionModel()
            if index == 0 {
                sectionModel.name = "1.AVFoundation介绍"
                sectionModel.rows = sectionOneData()
            }
            else if index == 1 {
                sectionModel.name = "2.播放和录制音频"
                sectionModel.rows = sectionTwoData()
            }
            result.append(sectionModel)
        }
        return result
    }
    
    static private func sectionOneData() -> [SWAVfounfationRowModel] {
        var rows = [SWAVfounfationRowModel]()
        for rowIndex in 0 ... 2 {
            if rowIndex == 0 {
                var rowModel = SWAVfounfationRowModel()
                rowModel.name = "1.AVSpeechUtterance简单语音播放播放"
                rowModel.selName = "simpleAVSpeechUtterance"
                rows.append(rowModel)
            }
            else if rowIndex == 1 {
                var rowModel = SWAVfounfationRowModel()
                rowModel.name = "2.中文语音播报"
                rowModel.selName = "simpleChineseRadio"
                rows.append(rowModel)
            }
            else if rowIndex == 2 {
                var rowModel = SWAVfounfationRowModel()
                rowModel.name = "3.英文播通知"
                rowModel.selName = "simpleEnglishRadio"
                rows.append(rowModel)
            }
        }
        return rows
    }
    
    static private func sectionTwoData() -> [SWAVfounfationRowModel] {
        var rows = [SWAVfounfationRowModel]()
        for rowIndex in 0 ... 2 {
            if rowIndex == 0 {
                var rowModel = SWAVfounfationRowModel()
                rowModel.name = "1.理解音频会话"
                rowModel.selName = "aboutAudioSession"
                rows.append(rowModel)
            }
            else if rowIndex == 1 {
                var rowModel = SWAVfounfationRowModel()
                rowModel.name = "2.使用AVAudioPlayer播放音频"
                rowModel.selName = "playerVoiceWithAvAudioPlayer"
                rows.append(rowModel)
            }
            else if rowIndex == 2 {
                var rowModel = SWAVfounfationRowModel()
                rowModel.name = "3.创建Audio Looper"
                rowModel.selName = "createAudioLooper"
                rows.append(rowModel)
            }
        }
        return rows
    }
    
    
    
    
}
