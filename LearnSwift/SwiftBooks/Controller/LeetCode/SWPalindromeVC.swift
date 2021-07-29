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
        
        
        
        
        tableView.reloadData()
        
    }
    
    @objc func palindrome() {
        let test1 = 121
        let test2 = -121
        let test3 = 0
        
        printLog("test1:\(checkIsPalindrome(test1)) \n test2:\(checkIsPalindrome(test2)) \n test3:\(checkIsPalindrome(test3))")
        
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
    
    
}
