//
//  SWTextView.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/11.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWTextView: UIView {
    

    class func defaultView() ->SWTextView {
        let bounds = UIScreen.main.bounds
        let frame  = CGRect(x: 0, y: 0, width:bounds.width , height: bounds.height)
        let myTextView = SWTextView.init(frame: frame)
        return myTextView
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(textView)
        self.addSubview(closeButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func dismissView()  {
        self.removeFromSuperview()
    }
    
    func showView()  {
        showView(in:UIApplication.shared.keyWindow! )
    }
    
    func showView(in mySuperView:UIView)  {
        mySuperView.addSubview(self)
        mySuperView.bringSubviewToFront(self)
    }
    
    func setText(_ text:String?)  {
        guard let myText = text else { return  }
        textView.text = myText
    }
    
    lazy var textView:UITextView = {
        let topY = topHairMargin + 44
        let myTextView = UITextView.init(frame: CGRect(x: 5, y: topY, width: ScreenW - 5 * 2, height: ScreenH - topY ))
        myTextView.isEditable = false
        myTextView.textColor = "#444444".color(alpha: 0.8)
        myTextView.font = UIFont.systemFont(ofSize: 15)
        return myTextView
    }()
    
    lazy var closeButton:UIButton = {
        weak var weakSelf = self
        let button = UIButton()
        button.setBackgroundImage(UIImage.init(named: "Close_Button"), for: .normal)
        button.addButtonEvent { (sender) in
            weakSelf?.dismissView()
        }
        button.frame = CGRect(x: textView.width - 50, y: topHairMargin + 10, width: 40, height: 40)
        return button
        
    }()

}
