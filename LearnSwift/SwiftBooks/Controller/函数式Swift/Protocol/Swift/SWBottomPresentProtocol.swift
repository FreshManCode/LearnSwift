//
//  SWBottomPresentProtocol.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/10/23.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController :UIViewControllerTransitioningDelegate {
    
    func presentBottom(_ vc : SWBottomPopViewController.Type)  {
        let controller = vc.init()
        controller.modalPresentationStyle = .custom
//        controller.transitioningDelegate = self
        self.present(controller, animated: true, completion: nil)
    }
    
//    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
//        let present = SWBottomPresentViewController(presentedViewController: presented, presenting: presenting)
//
//        if let bottomPopVC = presented as? SWBottomPopViewController {
//            present.controllerHeight = bottomPopVC.controllerHeight
//        }
//        return present
//    }
}
