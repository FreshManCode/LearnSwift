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
        listItemArray.append(SWBookListItem(title: "3.  反转字符串中的元音字母 ",
                                            subTitle: "",
                                            funName: "myReverseVowels"))
        
        
        
        
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

    // MARK: - 反转字符串中的元音字母
    @objc func myReverseVowels()  {
        /**
         给你一个字符串 s ，仅反转字符串中的所有元音字母，并返回结果字符串。

         元音字母包括 'a'、'e'、'i'、'o'、'u'，且可能以大小写两种形式出现。
         
         我们可以使用两个指针 i 和 j 对字符串相向地进行遍历。

         具体地，指针 i初始时指向字符串 s 的首位，指针 j 初始时指向字符串 s 的末位。在遍历的过程中，我们不停地将 i 向右移动，直到 i 指向一个元音字母（或者超出字符串的边界范围）；同时，我们不停地将 j 向左移动，直到 j 指向一个元音字母。此时，如果 i<j，那么我们交换 i 和 j 指向的元音字母，否则说明所有的元音字母均已遍历过，就可以退出遍历的过程

         链接：https://leetcode-cn.com/problems/reverse-vowels-of-a-string/solution/fan-zhuan-zi-fu-chuan-zhong-de-yuan-yin-2bmos/
         */
        let vowelMaps:[Character:Character] = ["a":"a","e":"e","i":"i","o":"o","u":"u","A":"A","E":"E","I":"I","O":"O","U":"U"]
        func isVowel (_ char:Character)->Bool {
            return vowelMaps[char] != nil
        }
        func reverseVowels(_ s: String) -> String {
            var chars = Array.init(s)
            var left = 0
            var right = chars.count - 1
            while left < right {
                
                while left < chars.count && !isVowel(chars[left]) {
                    left += 1
                }
                
                while right > 0 && !isVowel(chars[right]) {
                    right -= 1
                }
                
                if left < right {
                    let temp = chars[left]
                    chars[left] = chars[right]
                    chars[right] = temp
                    left += 1
                    right -= 1
                }
            }
            return String.init(chars)
        }
        
        print("hello->\(reverseVowels("hello"))")
        print("leetcode->\(reverseVowels("leetcode"))")
        
        
    }


    

    

}
