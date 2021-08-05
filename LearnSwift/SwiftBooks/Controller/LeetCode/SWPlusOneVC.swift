//
//  SWPlusOneVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/8/5.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWPlusOneVC: SWBaseViewController {
    
    let digits = [1,2,3]
    let digits2 = [4,3,2,1]
    let digits3 = [9,9,9,9]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
    }
    

    func p_initDefautData()  {
        title = "加一"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1.加一(自己实现) ",
                                            subTitle: "",
                                            funName: "myPlusOne"))

        
        
        tableView.reloadData()
    }
    
    // MARK: - 加一

    @objc func myPlusOne() {
        
        /** 加一
         
         给定一个由 整数 组成的 非空 数组所表示的非负整数，在该数的基础上加一。

         最高位数字存放在数组的首位， 数组中每个元素只存储单个数字。

         你可以假设除了整数 0 之外，这个整数不会以零开头。

          

         示例 1：
         输入：digits = [1,2,3]
         输出：[1,2,4]
         解释：输入数组表示数字 123。
         
         示例 2：
         输入：digits = [4,3,2,1]
         输出：[4,3,2,2]
         解释：输入数组表示数字 4321。
         
         示例 3：
         输入：digits = [9,9,9,9]
         输出：[1,0,0,0,0]
         解释：输入数组表示数字 10000。

        
         
         
         根据题意加一，没错就是加一这很重要，因为它是只加一的所以有可能的情况就只有两种：

         除 99 之外的数字加一；
         数字 99。
         加一得十进一位个位数为 00 加法运算如不出现进位就运算结束了且进位只会是一。

         所以只需要判断有没有进位并模拟出它的进位方式，如十位数加 11 个位数置为 00，如此循环直到判断没有再进位就退出循环返回结果。

         然后还有一些特殊情况就是当出现 9999、999999 之类的数字时，循环到最后也需要进位，出现这种情况时需要手动将它进一位。

         */
        print("digits:\(myPlusOne(digits))")
        print("digits2:\(myPlusOne(digits2))")
        print("digits3:\(myPlusOne(digits3))")
        
    }
    
    func myPlusOne(_ digits: [Int]) -> [Int] {
        var resultArray = digits
        var index = digits.count - 1
        while index >= 0 {
            let tailNumber = digits[index] + 1
            resultArray[index] = tailNumber
//          相加之和没有进位
            if tailNumber % 10 != 0 {
                return resultArray
            } else {
                resultArray[index] = 0
            }
            index = index - 1
        }
//      相加之和有进位,整体多了1位,高位为1,其它为0
        resultArray.insert(1, at: 0)
        return resultArray
    }
    
    func highEfficiencyLlusOne(_ digits: [Int]) -> [Int] {
            let count = digits.count
            var digits = digits
            for i in stride(from: count - 1, through: 0, by: -1) {
                digits[i] = (digits[i] + 1) % 10
                if digits[i] != 0 {
                    return digits
                }
            }
            var arr: [Int] = Array.init(repeating: 0, count: count + 1)
            arr[0] = 1
            return arr
        }

}
