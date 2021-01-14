//
//  MyUIViewControllerExtension.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/11.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import Foundation
import SCLAlertView

extension UIViewController {
    private var myTextView:SWTextView {
        let textView:SWTextView
        if let ExistedTextView = objc_getAssociatedObject(self, &MyExtensionKey.TextView) as? SWTextView {
            textView = ExistedTextView
        } else {
            textView = SWTextView.defaultView()
            objc_setAssociatedObject(self, &MyExtensionKey.TextView, textView, .OBJC_ASSOCIATION_RETAIN)
        }
        return textView
    }
    /// 设置浮动的文本显示内容
    /// - Parameter text: 文本内容
    func setText(_ text:String)  {
        myTextView.setText(text)
        myTextView.showView()
    }
    
    
    func show(title:String?,text:String?,okAction: @escaping ()->(Void))  {
        let alertView = SCLAlertView()
        
        
        alertView.addButton("确定", action: okAction)
        alertView.showInfo(title!, subTitle: text!)
        
    }
    
    
    /// 弹出Alert
    /// - Parameters:
    ///   - text: 内容
    ///   - okAction: 回调
    func showAlert(text:String,okAction:@escaping ()->(Void))  {
        show(title: "提示", text: text, okAction: okAction)
    }
    
    
    
}
