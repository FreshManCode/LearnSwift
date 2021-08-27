//
//  SWTwoSumVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/8/26.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWTwoSumVC: SWBaseViewController {
    
    let sum1 = [2,7,11,15]
    let sum2 = [2,3,4]
    let digitisMap:[Character:Int] = ["A":1,"B":2,"C":3,"D":4,"E":5,"F":6,"G":7,"H":8,"I":9,"J":10,"K":11,"L":12,"M":13,"N":14,"O":15,"P":16,"Q":17,"R":18,"S":19,"T":20,"U":21,"V":22,"W":23,"X":24,"Y":25,"Z":26]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
        
    }
    func p_initDefautData()  {
        title = " 两数之和 II - 输入有序数组"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1.  两数之和 II - 输入有序数组 ",
                                            subTitle: "",
                                            funName: "myTwoSum"))
        listItemArray.append(SWBookListItem(title: "1.1  两数之和 II - 输入有序数组 (双指针解法) ",
                                            subTitle: "",
                                            funName: "twoSum"))
        listItemArray.append(SWBookListItem(title: "2.Excel表列名称 ",
                                            subTitle: "",
                                            funName: "myConvertToTitle"))
        
        listItemArray.append(SWBookListItem(title: "3.Excel表列名称 ",
                                            subTitle: "",
                                            funName: "myConvertToNumber"))
        
        
        
        tableView.reloadData()
    }
    
    // MARK: - 两数之和 II - 输入有序数组
    @objc func myTwoSum()  {
        /*给定一个已按照 升序排列  的整数数组 numbers ，请你从数组中找出两个数满足相加之和等于目标数 target 。
         
         函数应该以长度为 2 的整数数组的形式返回这两个数的下标值。numbers 的下标 从 1 开始计数 ，所以答案数组应当满足 1 <= answer[0] < answer[1] <= numbers.length 。
         
         你可以假设每个输入只对应唯一的答案，而且你不可以重复使用相同的元素。
         
         1.每次遍历时检测curValue是否存在map中,如果存在,则当前的index,以及curValue 对应的value
         2.使用一个map来保存 target - curValue 的值
         
         */
        func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
            var tempMap = [Int:Int]()
            var result = [Int]()
            for index in 0..<numbers.count {
                let currentValue = numbers[index]
                if tempMap[currentValue] != nil {
                    result.append(tempMap[currentValue]! + 1)
                    result.append(index + 1)
                    break
                } else {
                    let numberValue = target - currentValue
                    tempMap[numberValue] = index
                }
            }
            return result
        }
        
        print("1:\(twoSum(sum1, 9))")
        print("1:\(twoSum(sum1, 18))")
        print("2:\(twoSum(sum2, 6))")
    }
    
    // MARK: - 两数之和 II - 输入有序数组 (双指针解法)
    @objc func twoSum()  {
        /**
         初始时两个指针分别指向第一个元素位置和最后一个元素的位置。每次计算两个指针指向的两个元素之和，并和目标值比较。如果两个元素之和等于目标值，则发现了唯一解。如果两个元素之和小于目标值，则将左侧指针右移一位。如果两个元素之和大于目标值，则将右侧指针左移一位。移动指针之后，重复上述操作，直到找到答案。
         
         链接：https://leetcode-cn.com/problems/two-sum-ii-input-array-is-sorted/solution/liang-shu-zhi-he-ii-shu-ru-you-xu-shu-zu-by-leet-2/
         */
        
        
        func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
            var left = 0
            var right = numbers.count - 1
            
            while left < right {
                let sumValue = numbers[left] + numbers[right]
                if sumValue == target {
                    return [left + 1,right + 1]
                }
                //比目标值小,向前移动
                else if (sumValue < target) {
                    left += 1
                }
                //比目标值大,向后移动
                else {
                    right -= 1
                }
            }
            return [-1,-1]
            
        }
        
        print("1:\(twoSum(sum1, 9))")
        print("1:\(twoSum(sum1, 18))")
        print("2:\(twoSum(sum2, 6))")
    }
    
    // MARK: - Excel表列名称
    @objc func myConvertToTitle()  {
        /**
         Excel 表列序号
         给你一个字符串 columnTitle ，表示 Excel 表格中的列名称。返回该列名称对应的列序号。
         例如，
         
         A -> 1
         B -> 2
         C -> 3
         ...
         Z -> 26
         AA -> 27
         AB -> 28
         ...
         
         解题思路
         标签：字符串遍历，进制转换
         初始化结果 ans = 0，遍历时将每个字母与 A 做减法，因为 A 表示 1，所以减法后需要每个数加 1，计算其代表的数值 num = 字母 - ‘A’ + 1
         因为有 26 个字母，所以相当于 26 进制，每 26 个数则向前进一位
         所以每遍历一位则ans = ans * 26 + num
         以 ZY 为例，Z 的值为 26，Y 的值为 25，则结果为 26 * 26 + 25=701
         时间复杂度：O(n)
         
         链接：https://leetcode-cn.com/problems/excel-sheet-column-number/solution/hua-jie-suan-fa-171-excelbiao-lie-xu-hao-by-guanpe/
         
         */
        func convertToTitle(_ columnNumber: String) -> Int {
            let charArray:[Character] = Array.init(columnNumber)
            var answer = 0
            for index in 0 ..< columnNumber.count {
                let number = digitisMap[charArray[index]]! - digitisMap["A"]! + 1
                answer = answer * 26 + number
            }
            return answer
        }
        
        func titleToNumber(_ columnTitle: String) -> Int {
            let ch: Character = "A"
            let flag_idx = ch.asciiValue! - 1
            let c = Array(columnTitle)
            var ans = 0
            let n = c.count
            for i in 0..<n {
                let cc = c[i]
                ans = ans * 26 + Int((cc.asciiValue! - flag_idx))
            }
            return ans
        }
        
        print("1:\(convertToTitle("ZY"))")
        print("2:\(convertToTitle("FXSHRXW"))")
        
    }
    
    
    // MARK: - Excel表列名称
    @objc func myConvertToNumber()  {
        /**
         给你一个整数 columnNumber ，返回它在 Excel 表中相对应的列名称。

         例如：

         A -> 1
         B -> 2
         C -> 3
         ...
         Z -> 26
         AA -> 27
         AB -> 28
         ...

         示例 1：

         输入：columnNumber = 1
         输出："A"
         示例 2：

         输入：columnNumber = 28
         输出："AB"
         
         
         题解:这是一道从 11 开始的的 2626 进制转换题。
         
         对于一般性的进制转换题目，只需要不断地对 columnNumbercolumnNumber 进行 % 运算取得最后一位，然后对 columnNumbercolumnNumber 进行 / 运算，将已经取得的位数去掉，直到 columnNumbercolumnNumber 为 00 即可。

         一般性的进制转换题目无须进行额外操作，是因为我们是在「每一位数值范围在 [0,x)[0,x)」的前提下进行「逢 xx 进一」。

         但本题需要我们将从 11 开始，因此在执行「进制转换」操作前，我们需要先对 columnNumbercolumnNumber 执行减一操作，从而实现整体偏移。

         链接：https://leetcode-cn.com/problems/excel-sheet-column-title/solution/gong-shui-san-xie-cong-1-kai-shi-de-26-j-g2ur/
         */
        
        func convertNumberToString(_ columnNumber:Int) -> String {
            var result = ""
            let flag:Character = "A"
            var number = columnNumber
            let divide = 26
            while number > 0 {
                number -= 1
                let resultAssiiNumber = number % divide + Int(flag.asciiValue!)
                let char = Character(UnicodeScalar(resultAssiiNumber)!)
                result = "\(char)\(result)"
                number /= divide
            }
            return result
        }
        
        
        print("701:\(convertNumberToString(701))")
        
        print("2147483647:\(convertNumberToString(2147483647))")
        
    }

}
