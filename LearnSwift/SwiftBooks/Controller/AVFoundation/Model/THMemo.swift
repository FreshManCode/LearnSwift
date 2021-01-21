//
//  THMemo.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/20.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import Foundation

class THMemo:NSObject,NSCoding {
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: "title")
        coder.encode(url, forKey: "url")
        coder.encode(dateString, forKey: "dateString")
        coder.encode(timeString, forKey: "timeString")
    }
    
    required init?(coder: NSCoder) {
        title = coder.decodeObject(forKey: "title") as? String
        url = coder.decodeObject(forKey: "url") as? URL
        dateString = coder.decodeObject(forKey: "dateString") as? String
        timeString = coder.decodeObject(forKey: "timeString") as? String
    }
    
    var title:String?
    var url:URL?
    var dateString:String?
    var timeString:String?
    
    static func memo(with title:String,url:URL) -> THMemo {
        let instance = THMemo.init(with: title, url: url)
        return instance
    }
    
    init(with title:String,url:URL) {
        super.init()
        self.title = title
        self.url = url
        let date = Date()
        dateString = dateString(with:date)
        timeString = timeString(with: date)
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
