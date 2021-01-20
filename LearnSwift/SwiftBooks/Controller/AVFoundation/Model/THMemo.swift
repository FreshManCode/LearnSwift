//
//  THMemo.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/20.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import Foundation

struct THMemo {
    var title:String?
    var url:URL?
    var dateString:String?
    var timeString:String?
    
    static func memo(with title:String,url:URL) -> THMemo {
        let instance = THMemo.init(with: title, url: url)
        return instance
    }
    
    init(with title:String,url:URL) {
        self.title = title
        self.url = url
    }
    
    func deleteMemo() ->Bool  {
        guard let myURL = url else { return false }
        var success = false
        do {
            try FileManager.default.removeItem(at: myURL)
            success = true
        } catch  {
            success = false
            printLog("error is:\(error)")
        }
        return success
    }
    
    
    func dateString(with Date:Date) -> String {
        return self.formatter(with: "MMddyyyy").string(from: Date)
    }
    func timeString(with Date:Date) -> String {
        return formatter(with: "HHmmss").string(from: Date)
    }
    
    func formatter(with format:String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: format, options: 0, locale: Locale.current)
        return formatter
    }
    
    
    
}
