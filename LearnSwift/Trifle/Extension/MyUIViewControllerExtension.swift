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
            textView.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
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
    
    
    /// 弹出保存录音Alert
    /// - Parameters:
    ///   - placeholder: placeholder
    ///   - okAction: 回调
    /// - Returns: Void
    func showAlertWithInput(placeholder:String,
                            okAction:@escaping (_ text:String?)->())  {
        let alertView = SCLAlertView(appearance: myAppearance)
        weak var weakAlertView = alertView
        let text = alertView.addTextField(placeholder)
        alertView.addButton("保存") {
            guard let myText = text.text else {
                return
            }
            okAction(myText)
            weakAlertView?.dismiss(animated: true, completion: nil)
            
        }
        alertView.addButton("关闭") {
            weakAlertView?.dismiss(animated: true, completion: nil)
        }
        alertView.showEdit("保存录音", subTitle: "请输入文件名")
        
    }
    
    private var myAppearance:SCLAlertView.SCLAppearance {
        return
            SCLAlertView.SCLAppearance(
                kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
                kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
                kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
                showCloseButton: false)
    }
    
    
    
}
