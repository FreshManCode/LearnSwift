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
    
    let string = ["11","1"]
    let string2 = ["111111","111111"]
    let string3 = ["1010","1011"]
    
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
        
        listItemArray.append(SWBookListItem(title: "2.二进制求和 ",
                                            subTitle: "",
                                            funName: "myAddBinary"))
        
        listItemArray.append(SWBookListItem(title: "3.二进制求和(优化) ",
                                            subTitle: "",
                                            funName: "moreEfficiencyAddBinary"))
        
        
        
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
    
    //  自己写的算法
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
    
    //  效率高的算法
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
    
    
    // MARK: - 二进制求和
    @objc func myAddBinary() {
        /**
         二进制求和
         给你两个二进制字符串，返回它们的和（用二进制表示）。
         
         输入为 非空 字符串且只包含数字 1 和 0。
         
          
         
         示例 1:
         
         输入: a = "11", b = "1"
         输出: "100"
         示例 2:
         
         输入: a = "1010", b = "1011"
         输出: "10101"
         
         */
        print("string:\(addBinary(string[0], string[1]))")
        print("string2:\(addBinary(string2[0], string2[1]))")
        print("string3:\(addBinary(string3[0], string3[1]))")
        
    }
    
    @objc func moreEfficiencyAddBinary() {
        
    }
    
    func addBinary(_ a: String, _ b: String) -> String {
        let arrayA:[Character] = Array.init(a.reversed())
        let arrayB:[Character] = Array.init(b.reversed())
        let countA = arrayA.count
        let countB = arrayB.count
        let maxLength = max(countA, countB)
        var result = ""
        //      是否需要进位
        var nextIndex = 0
        
        for index in 0..<maxLength {
            var numberA = 0
            var numberB = 0
            if index < countA {
                numberA = Int.init("\(arrayA[index])") ?? 0
            }
            if index < countB {
                numberB = Int.init("\(arrayB[index])") ?? 0
            }
            
            let plusValue = numberA + numberB
            if plusValue == 2 {
                result.append(nextIndex > 0 ? "1" : "0")
                nextIndex = index + 1
            } else {
                if nextIndex > 0 {
                    if plusValue + 1 == 2 {
                        result.append("0")
                        nextIndex = index + 1
                    } else {
                        nextIndex = 0
                        result.append("\(plusValue + 1)")
                    }
                } else {
                    result.append("\(plusValue)")
                }
            }
        }
        if nextIndex == maxLength {
            result.append("1")
        }
        let resultStr = String(result.reversed())
        return resultStr
    }
    
    
    func moreEfficiencyaddBinary(_ a: String, _ b: String) -> String {
        var result = ""
        
        var aArray: [Character] = []
        var bArray: [Character] = []
        
        for signalA in a {
            aArray.append(signalA)
        }
        
        for signalB in b {
            bArray.append(signalB)
        }
        
//      进位标志
        var carry = 0 // 进位
        
        var ai = aArray.count - 1
        var bi = bArray.count - 1
        
        while true {
            
            var numA = 0
            var numB = 0
            
            if ai >= 0 {
                let signalA = String(aArray[ai])
                numA = Int(signalA) ?? 0
            }
            
            if bi >= 0 {
                let signalB = String(bArray[bi])
                numB = Int(signalB) ?? 0
            }
            
            let sum = numA + numB
            
            if sum == 2 { // 当前位数变成0
                
                if carry == 1 {
                    result.insert("1", at:result.startIndex)
                } else {
                    result.insert("0", at:result.startIndex)
                }
                carry = 1
            } else if (sum == 1) {
                if carry == 1 {
                    result.insert("0", at: result.startIndex)
                    carry = 1
                } else {
                    result.insert("1", at: result.startIndex)
                    carry = 0
                }
            } else {
                if carry == 1 {
                    result.insert("1", at: result.startIndex)
                } else {
                    result.insert("0", at: result.startIndex)
                }
                carry = 0
            }
            ai -= 1
            bi -= 1
            if bi < 0 && ai < 0 {
                break
            }
        }
        
        if carry == 1 {
            result.insert("1", at: result.startIndex)
        }
        
        return result
    }
    
    
    
    
}
