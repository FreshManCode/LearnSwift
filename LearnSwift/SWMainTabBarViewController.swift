//
//  SWMainTabBarViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/6/8.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWMainTabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        let homeNav = SWBaseNavigationController.init(rootViewController: SWHomeViewController());
        self.setUpItem(vc: homeNav, normalImage: "电影-灰", highImage: "电影-亮", title: "首页");
        
        let bookNav = SWBaseNavigationController.init(rootViewController: SWBookListViewController());
        self.setUpItem(vc: bookNav, normalImage: "电影-灰", highImage: "电影-亮", title: "书店");
        
        let findNav = SWBaseNavigationController.init(rootViewController: SWFindViewController());
        self.setUpItem(vc: findNav, normalImage: "广场-灰", highImage: "广场-亮", title: "发现")
        
        let trifleNav = SWBaseNavigationController.init(rootViewController: SWTrifleViewController());
        self.setUpItem(vc: trifleNav, normalImage: "广场-灰", highImage: "广场-亮", title: "琐事")
        
        
        self.setViewControllers([homeNav,bookNav,findNav,trifleNav], animated: false);
        self.delegate = self;
        super.viewDidLoad()
    }
    

    func setUpItem(vc:UIViewController,normalImage:String,highImage:String,title:String) -> Void {
        vc.tabBarItem.title = title;
        vc.tabBarItem.image = UIImage.init(named: normalImage);
        vc.tabBarItem.selectedImage = UIImage.init(named: highImage);
        
        let color = UIColor.init(red: 56/255.0, green: 211/255.0, blue: 221/255.0, alpha: 1.0);
        let color_normal = UIColor.init(red: 0.53, green: 0.53, blue: 0.54, alpha: 1.0);
        
        let attributeDic = [NSAttributedString.Key.foregroundColor:color];
        vc.tabBarItem.setTitleTextAttributes(attributeDic, for: UIControl.State.selected);
        
        let attributeDic_normal = [NSAttributedString.Key.foregroundColor:color_normal];
        vc.tabBarItem.setTitleTextAttributes(attributeDic_normal, for: UIControl.State.normal);
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//      发送加载完毕的通知,来提前创建webviwe
        printLog("myPost")
        mySimplePost(name: kMainControllerInitSuccessKey, object: nil)
    }

}

// MARK: - UITabBarControllerDelegate

