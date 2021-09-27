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
        listItemArray.append(SWBookListItem(title: "2.  反转字符串 ",
                                            subTitle: "",
                                            funName: "myReverseString"))
        
        
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
    
    // MARK: - 反转字符串
    @objc func myReverseString()  {
        /**
         编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组 s 的形式给出。

         不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用 O(1) 的额外空间解决这一问题。
         
         双指针:left与right,互相交换,然后两个指针逐渐往中间移动
         */
        func reverseString(_ s: inout [Character]) {
            var left = 0,right = s.count - 1
            while left < right {
                let temp = s[left]
                s[left] = s[right]
                s[right] = temp
                left += 1
                right -= 1
            }
            
        }
        
    }


    

    

}
