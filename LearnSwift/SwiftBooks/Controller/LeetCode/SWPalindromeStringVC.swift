//
//  SWPalindromeStringVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/8/19.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWPalindromeStringVC: SWBaseViewController {
    
    let singleNums1 =  [2,2,1]
    let singleNums2 =  [4,1,2,1,2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        p_initDefautData()
    }
    
    
    func p_initDefautData()  {
        title = "验证回文串"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1. 验证回文串 ",
                                            subTitle: "",
                                            funName: "myPalindrome"))
        listItemArray.append(SWBookListItem(title: "1.1 验证回文串(优化) ",
                                            subTitle: "",
                                            funName: "modifyPalindrome"))
        listItemArray.append(SWBookListItem(title: "2.只出现一次的数字 ",
                                            subTitle: "",
                                            funName: "singleNumber"))
        listItemArray.append(SWBookListItem(title: "2.1 只出现一次的数字优化 ",
                                            subTitle: "",
                                            funName: "modifySingleNumber"))
        
        
        
        
        
        
        
        tableView.reloadData()
    }
    
    // MARK: - 1.验证回文串
    @objc func myPalindrome()  {
        /**
         给定一个字符串，验证它是否是回文串，只考虑字母和数字字符，可以忽略字母的大小写。
         
         说明：本题中，我们将空字符串定义为有效的回文串。
         
         示例 1:
         
         输入: "A man, a plan, a canal: Panama"
         输出: true
         解释："amanaplanacanalpanama" 是回文串
         
         示例 2:
         输入: "race a car"
         输出: false
         解释："raceacar" 不是回文串
         
         */
        let input1 = "A man, A plan, a canal: Panama"
        let input2 = "race a car"
        
        print("1:\(isPalindrome(input1))")
        print("2:\(isPalindrome(input2))")
    }
    
    func isPalindrome(_ s: String) -> Bool {
        /**
         第二种是使用双指针。初始时，左右指针分别指向 \textit{sgood}sgood 的两侧，随后我们不断地将这两个指针相向移动，每次移动一步，并判断这两个指针指向的字符是否相同。当这两个指针相遇时，就说明 \textit{sgood}sgood 时回文串。
         
         作者：LeetCode-Solution
         链接：https://leetcode-cn.com/problems/valid-palindrome/solution/yan-zheng-hui-wen-chuan-by-leetcode-solution/
         来源：力扣（LeetCode）
         著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
         */
        let smallString = s.lowercased()
        //      先把除字母/数字之外的字符全部过滤掉
        let pattern = "[^a-zA-Z0-9]"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let regexStr = regex?.stringByReplacingMatches(in: smallString, options: [], range: NSMakeRange(0, smallString.count), withTemplate: "")
        let chars:[Character] = Array.init(regexStr ?? "")
        var left = 0
        var right = chars.count - 1
        while left <= right {
            if chars[left] != chars[right] {
                return false
            }
            left += 1
            right -= 1
        }
        return true
    }
    
    // MARK: - 优化验证是否是回文串
    @objc func modifyPalindrome()  {
        /// 优化后的双指针解法
        /// - Parameter s: 原始字符串
        /// - Returns: 是否是回文串结果
        func modifyisPalindrome(_ s: String) -> Bool {
            var list:[UInt32] = []
            //          先筛选出满足条件的字符 (比直接使用正则表达式效率要高)
            for char in s.uppercased().unicodeScalars {
                if (char.value >= 48 && char.value <= 57) || (char.value >= 65 && char.value <= 90) {
                    list.append(char.value)
                }
            }
            var left = 0
            var right = list.count - 1
            while left < right {
                if list[left] != list[right] {
                    return false
                }
                left += 1
                right -= 1
            }
            return true
        }
        
        /// 效率更高的双指针法
        /// - Parameter s: 原始字符串
        /// - Returns: 返回字符串
        func isPalindrome(_ s: String) -> Bool {
            let array:[Character] = Array(s.lowercased())
            var left = 0, right = array.count - 1
            while left < right {
                if !array[left].isLetter && !array[left].isNumber {
                    left += 1
                    continue
                }
                if !array[right].isLetter && !array[right].isNumber {
                    right -= 1
                    continue
                }
                if array[left] != array[right] {
                    return false
                }
                left += 1
                right -= 1
            }
            
            return true
        }
        
    }
    
    
    
    // MARK: - 只出现一次的数字
    @objc func singleNumber()  {
        /**
         给定一个非空整数数组，除了某个元素只出现一次以外，其余每个元素均出现两次。找出那个只出现了一次的元素。
         
         说明：
         
         你的算法应该具有线性时间复杂度。 你可以不使用额外空间来实现吗？
         
         示例 1:
         
         输入: [2,2,1]
         输出: 1
         示例 2:
         
         输入: [4,1,2,1,2]
         输出: 4
         
         链接：https://leetcode-cn.com/problems/single-number
         */
        
        func caculateSingleNumber(_ nums: [Int]) -> Int {
            var tempDic = [Int:Int]()
            for item in nums {
                if tempDic[item] != nil {
                    tempDic.removeValue(forKey: item)
                } else {
                    tempDic[item] = item
                }
            }
            return tempDic.keys.first!
        }
        
        print("result1:\(caculateSingleNumber(singleNums1))")
        print("result2:\(caculateSingleNumber(singleNums2))")

    }
    
    // MARK: - 2.1 只出现一次的数字优化
    @objc func modifySingleNumber()  {
        /**
         使用位运算。对于这道题，可使用异或运算 ⊕。异或运算有以下三个性质。

         任何数和 0 做异或运算，结果仍然是原来的数，即 a⊕0=a。
         任何数和其自身做异或运算，结果是 0，即 a⊕a=0。
         异或运算满足交换律和结合律，即 a⊕b⊕a=b⊕a⊕a=b⊕(a⊕a)=b⊕0=b。

         链接：https://leetcode-cn.com/problems/single-number/solution/zhi-chu-xian-yi-ci-de-shu-zi-by-leetcode-solution/
         
         */
        func caculateSingleNumber(_ nums: [Int]) -> Int {
            var single = 0
            for item in nums {
//              使用异或运算符
                single = single ^ item
            }
            return single
            
        }
        
        print("result1:\(caculateSingleNumber(singleNums1))")
        print("result2:\(caculateSingleNumber(singleNums2))")
        
    }

    
    
    
    
    
}
