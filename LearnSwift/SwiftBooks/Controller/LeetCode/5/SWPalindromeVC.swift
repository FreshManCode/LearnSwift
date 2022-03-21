//
//  SWPalindromeVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/7/28.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWPalindromeVC: SWBaseViewController {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData();
        
        // Do any additional setup after loading the view.
    }
    
    /*
     题目描述:回文数
     
     给你一个整数 x ，如果 x 是一个回文整数，返回 true ；否则，返回 false 。
     
     回文数是指正序（从左向右）和倒序（从右向左）读都是一样的整数。例如，121 是回文，而 123 不是。
     
     -1111 不是
     0 是
     121 是
     12321 是
     
     来源：力扣（LeetCode）
     链接：https://leetcode-cn.com/problems/palindrome-number
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     
     */
    
    func p_initDefautData()  {
        title = "回文数"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "回文数 ",
                                            subTitle: "",
                                            funName: "palindrome"))
        listItemArray.append(SWBookListItem(title: "回文串",
                                            subTitle: "",
                                            funName: "palindromeString"))
        
        
        
        
        tableView.reloadData()
        
    }
    
    @objc func palindrome() {
        let test1 = 121
        let test2 = -121
        let test3 = 0
        
        printLog("test1:\(checkIsPalindrome(test1)) \n test2:\(checkIsPalindrome(test2)) \n test3:\(checkIsPalindrome(test3))")
        
        printLog("mytest1:\(myCheckIsPalindrome(test1)) \n mytest2:\(myCheckIsPalindrome(test2)) \n mytest3:\(myCheckIsPalindrome(test3))")
        
    }
    
    
    func myCheckIsPalindrome(_ x :Int) -> Bool {
        if (x < 0) {
            return false
        }
        var currentValue = x
        var result = 0
        while currentValue != 0 {
            let tail = currentValue % 10
            result = result * 10 + tail
            currentValue = currentValue / 10
        }
        return result == x
        
    }
    
    func checkIsPalindrome(_ x:Int) -> Bool {
        return x > 0 ? checkPositive(x) : checkNonPositive(x)
    }
    
    func checkNonPositive(_ x:Int) -> Bool {
        return x == 0 ? true : false
    }
    func checkPositive(_ x:Int) -> Bool {
        var input = x
        var result = 0
        
        while input != 0 {
            let tail = input % 10
            result = result * 10 + tail
            input = input / 10
        }
        return result == x
    }
    
    
    // MARK: - 验证是否是回文串
     @objc func palindromeString()  {
         let string  = "121"
         let string2 = "1221"
         let string3 = "abccb1"
                  
         printLog("string_result:\(checkIsPalindromeString(string))")
         printLog("string2_result:\(checkIsPalindromeString(string2))")
         printLog("string3_result:\(checkIsPalindromeString(string3))")
 
    }
    
    func checkIsPalindromeString(_ input : String) -> Bool  {
        let inputLength = input.count
        var left = 0
        var right = inputLength
        var startIndex = 0
        while (left <= right) {
            let leftChar  = input[input.index(input.startIndex, offsetBy: startIndex) ]
            let rightChar = input[input.index(input.startIndex, offsetBy: inputLength - startIndex - 1)]
            printLog("leftChar is:\(leftChar) rightChar is:\(rightChar)")
            startIndex += 1
            left += 1
            right -= 1
            if (leftChar != rightChar) {
                return false
            }
        }
        return true
        
    }
    
}
