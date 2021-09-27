//
//  SWIsPowerOfFourVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/9/27.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWIsPowerOfFourVC: SWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
    }
    
    func p_initDefautData()  {
        title = " 丢失的数字"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1.  4的幂 ",
                                            subTitle: "",
                                            funName: "myIsPowerOfFour"))
        tableView.reloadData()
    }
    
    // MARK: - 1.  4的幂
    @objc func myIsPowerOfFour()  {
        /**
         给定一个整数，写一个函数来判断它是否是 4 的幂次方。如果是，返回 true ；否则，返回 false 。

         整数 n 是 4 的幂次方需满足：存在整数 x 使得 n == 4x
         */
        func isPowerOfFour(_ n: Int) -> Bool {
            var number = n
            while number % 4 == 0 && number > 1 {
                number = number / 4
                print("number:\(number)")
            }
            return number == 1
        }
        print("16:\(isPowerOfFour(16) ? "true" : "false")")
        
    }

    

    

}
