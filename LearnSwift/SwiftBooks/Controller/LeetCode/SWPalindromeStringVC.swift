//
//  SWPalindromeStringVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/8/19.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWPalindromeStringVC: SWBaseViewController {
    
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
    
}
