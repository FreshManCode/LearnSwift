//
//  SWBaseNavigationController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/6/16.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = !viewController.isHomeRootVc
        super.pushViewController(viewController, animated: animated);
    }
}

extension UIViewController {
    /// tabbar首页的VC
    var rootTabViewControllers:[AnyClass] {
        [SWHomeViewController.self,
         SWFindViewController.self,
         SWBookListViewController.self,
         SWTrifleViewController.self]
    }
    
    
    /// 判断当前的VC是否是Tabbar的几个跟试图之一
    var isHomeRootVc:Bool {
        var result = false
        for MyClass in self.rootTabViewControllers {
            if self.isKind(of: MyClass) {
                result = true
                break
            }
        }
        return result
    }
    
}
