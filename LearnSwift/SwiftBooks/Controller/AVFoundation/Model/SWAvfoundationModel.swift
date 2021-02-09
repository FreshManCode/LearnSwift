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
        for index in 0 ..< 4 {
            var sectionModel = SWAVfounfationSectionModel()
            if index == 0 {
                sectionModel.name = "1.AVFoundation介绍"
                sectionModel.rows = sectionOneData()
            }
            else if index == 1 {
                sectionModel.name = "2.播放和录制音频"
                sectionModel.rows = sectionTwoData()
            }
            else if index == 2 {
                sectionModel.name = "3.资源和元数据"
                sectionModel.rows = sectionThreeData()
            }
            else if index == 3 {
                sectionModel.name = "4.视频播放"
                sectionModel.rows = sectionFourData()
            }
            result.append(sectionModel)
        }
        return result
    }
    
    static private func sectionOneData() -> [SWAVfounfationRowModel] {
        var rows = [SWAVfounfationRowModel]()
        for rowIndex in 0 ... 3 {
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
            else if rowIndex == 3 {
                var rowModel = SWAVfounfationRowModel()
                rowModel.name = "4.资源和元数据"
                rowModel.selName = "resourceAndAsset"
                rows.append(rowModel)
            }
        }
        return rows
    }
    
    static private func sectionTwoData() -> [SWAVfounfationRowModel] {
        var rows = [SWAVfounfationRowModel]()
        for rowIndex in 0 ... 6 {
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
            else if rowIndex == 3 {
                var rowModel = SWAVfounfationRowModel()
                rowModel.name = "4.配置音频会话"
                rowModel.selName = "configAudioSession"
                rows.append(rowModel)
            }
            else if rowIndex == 4 {
                var rowModel = SWAVfounfationRowModel()
                rowModel.name = "5.处理中断事件"
                rowModel.selName = "handleInterruptionEvent"
                rows.append(rowModel)
            }
            else if rowIndex == 5 {
                var rowModel = SWAVfounfationRowModel()
                rowModel.name = "6.对线路改变的响应"
                rowModel.selName = "respondToChangeLine"
                rows.append(rowModel)
            }
            else if rowIndex == 6 {
                var rowModel = SWAVfounfationRowModel()
                rowModel.name = "7.使用AVAudioRecorder录制音频"
                rowModel.selName = "useAVAudioRecorder"
                rows.append(rowModel)
            }
        }
        return rows
    }
    
    static private func sectionThreeData() -> [SWAVfounfationRowModel] {
        var rows = [SWAVfounfationRowModel]()
        for rowIndex in 0 ... 3 {
            if rowIndex == 0 {
                var rowModel = SWAVfounfationRowModel()
                rowModel.name = "1.理解资源的含义"
                rowModel.selName = "resourceAndAsset"
                rows.append(rowModel)
            }
            else if rowIndex == 1 {
                var rowModel = SWAVfounfationRowModel()
                rowModel.name = "2.iOS iPod库"
                rowModel.selName = "iOSiPodResource"
                rows.append(rowModel)
            }
            else if rowIndex == 2 {
                var rowModel = SWAVfounfationRowModel()
                rowModel.name = "3.3 异步载入"
                rowModel.selName = "asyncLoad"
                rows.append(rowModel)
            }
            else if rowIndex == 3 {
                var rowModel = SWAVfounfationRowModel()
                rowModel.name = "3.4 媒体元数据"
                rowModel.selName = "mediaAsset"
                rows.append(rowModel)
            }
        }
        return rows
    }
    
    static private func sectionFourData() -> [SWAVfounfationRowModel] {
        var rows = [SWAVfounfationRowModel]()
        for rowIndex in 0 ... 3 {
            if rowIndex == 0 {
                var rowModel = SWAVfounfationRowModel()
                rowModel.name = "1.视频播放功能综述"
                rowModel.selName = "playVideoSummary"
                rows.append(rowModel)
            }
            else if rowIndex == 1 {
                var rowModel = SWAVfounfationRowModel()
                rowModel.name = "2.播放秘籍"
                rowModel.selName = "playSecretary"
                rows.append(rowModel)
            }
            else if rowIndex == 2 {
                var rowModel = SWAVfounfationRowModel()
                rowModel.name = "4.3 处理时间"
                rowModel.selName = "handleTime"
                rows.append(rowModel)
            }
            else if rowIndex == 3 {
                var rowModel = SWAVfounfationRowModel()
                rowModel.name = "4.4 创建视频播放器"
                rowModel.selName = "createVideoPlayer"
                rows.append(rowModel)
            }
            else if rowIndex == 4 {
                var rowModel = SWAVfounfationRowModel()
                rowModel.name = "5.处理中断事件"
                rowModel.selName = "handleInterruptionEvent"
                rows.append(rowModel)
            }
            else if rowIndex == 5 {
                var rowModel = SWAVfounfationRowModel()
                rowModel.name = "6.对线路改变的响应"
                rowModel.selName = "respondToChangeLine"
                rows.append(rowModel)
            }
            else if rowIndex == 6 {
                var rowModel = SWAVfounfationRowModel()
                rowModel.name = "7.使用AVAudioRecorder录制音频"
                rowModel.selName = "useAVAudioRecorder"
                rows.append(rowModel)
            }
        }
        return rows
    }
    
    
    
    
}
