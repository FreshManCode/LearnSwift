//
//  SWBottomPresentViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/10/23.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

public class SWBottomPresentViewController: UIPresentationController {
    
    var controllerHeight: CGFloat = 300
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentedViewController)
    }
    
    public override func presentationTransitionWillBegin() {
        blackView.alpha = 0
        self.containerView?.addSubview(blackView)
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 1.0
        }
    }
    
    public override func dismissalTransitionWillBegin() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
        }
    }
    
    public override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            blackView.removeFromSuperview()
        }
    }
    
    //  弹出框在屏幕中的位置,需要底部弹出框
    public override var frameOfPresentedViewInContainerView: CGRect {
        return CGRect(x: 0,
                      y: ScreenH - controllerHeight,
                      width: ScreenW,
                      height:controllerHeight)
    }
    
    
    
    lazy var blackView:UIView = {
        let view = UIView()
        if let frame = self.containerView?.bounds {
            view.frame = frame
        }
        view.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        return view
    }()
}
