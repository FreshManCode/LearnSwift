//
//  SWTrailingZeroesVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/8/30.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWTrailingZeroesVC: SWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
    }
    

    func p_initDefautData()  {
        title = "相同的树-对称二叉树"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1.阶乘后的0 ",
                                            subTitle: "",
                                            funName: "myTrailingZeros"))
        listItemArray.append(SWBookListItem(title: "1.1 阶乘后的0 (优化) ",
                                            subTitle: "",
                                            funName: "myModifyTrailingZeros"))
        
        
        
        tableView.reloadData()
    }
    
    // MARK: - 阶乘后的0
    @objc func myTrailingZeros()  {
        /**
         
         阶乘后的零
         给定一个整数 n，返回 n! 结果尾数中零的数量。

         示例 1:

         输入: 3
         输出: 0
         解释: 3! = 6, 尾数中没有零。
         示例 2:

         输入: 5
         输出: 1
         解释: 5! = 120, 尾数中有 1 个零.

         */
        
        func trailingNumber(_ n:Int) -> Int {
            if n <= 2 {
                return n
            }else {
                return n * trailingNumber(n - 1)
            }
        }
        /**
         解法一:先使用阶乘计算出来这一项,然后在根据尾数是否能被0整除.逐渐移动位置计算.在n>20时就会溢出.不可取
         */
        func trailingZeroes(_ n: Int) -> Int {
            var resultCount = 0
            var lastNumber = trailingNumber(n)
            while lastNumber % 10 == 0 {
                resultCount += 1
                lastNumber = lastNumber / 10
            }
            return resultCount
        }
        print("10:\(trailingZeroes(10))")
        print("15:\(trailingZeroes(15))")
    }
    
    // MARK: - 阶乘后的0 (优化)
    @objc func myModifyTrailingZeros()  {
        /**
         解题思路
         计算有多少个5，就有多个0。因为5前面一定有2根他乘
         但是25有两个5，125有三个，也就是5的n次算会产生n个0
         所以递归中每次计算5的某次方有产生多少个0

         链接：https://leetcode-cn.com/problems/factorial-trailing-zeroes/solution/yi-xing-dai-ma-di-gui-logn-by-hello-5c-o81a/
         */
        func trailingZeroes(_ n: Int) -> Int {
            return n >= 5  ? n / 5 + trailingZeroes(n / 5) : 0
        }
        
    }

}
