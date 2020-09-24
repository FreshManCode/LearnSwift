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
        if !(viewController.isKind(of: SWHomeViewController.self) ||
            viewController.isKind(of: SWFindViewController.self) ||
            viewController.isKind(of: SWBookListViewController.self)) {
            viewController.hidesBottomBarWhenPushed = true;
        }
        super.pushViewController(viewController, animated: animated);
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
