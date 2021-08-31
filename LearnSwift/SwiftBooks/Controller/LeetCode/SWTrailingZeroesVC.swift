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
        listItemArray.append(SWBookListItem(title: "2. 快乐数(效率低) ",
                                            subTitle: "",
                                            funName: "myIsHappy"))
        listItemArray.append(SWBookListItem(title: "2.1 快乐数(快慢指针) ",
                                            subTitle: "",
                                            funName: "isHappyFastAndSlowPointer"))
        
        
        
        
        
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
    
    // MARK: - 2. 快乐数
    @objc func myIsHappy()  {
        /**
         编写一个算法来判断一个数 n 是不是快乐数。
         
         「快乐数」定义为：
         
         对于一个正整数，每一次将该数替换为它每个位置上的数字的平方和。
         然后重复这个过程直到这个数变为 1，也可能是 无限循环 但始终变不到 1。
         如果 可以变为  1，那么这个数就是快乐数。
         如果 n 是快乐数就返回 true ；不是，则返回 false
         */
        
        func isHappy(_ n: Int) -> Bool {
            /**
             把给定的数进行分解,然后按照平方和进行比较.
             */
            var index = 0
            var number = n
            var tempArray = [Int]()
            while index < 100 {
                if number < 10 {
                    if tempArray.count == 0 {
                        if number * number != 1 && number * number < 10 {
                            return false
                        }
                    }
                    
                    var result = 0
                    index += 1
                    tempArray.append(number)
                    for item in tempArray {
                        result += item * item
                    }
                    number = result
                    if result == 1 {
                        return true
                    } else {
                        tempArray.removeAll()
                    }
                } else {
                    tempArray.append(number % 10)
                    number = number / 10
                }
            }
            return false
        }
        print("23:\(isHappy(23))")
        print("19:\(isHappy(19))")
        print("2:\(isHappy(2))")
    }
    
    // MARK: - 快乐数(快慢指针)
    @objc func isHappyFastAndSlowPointer()  {
        /**
         解题思路：
         方法：
         使用 “快慢指针” 思想，找出循环：“快指针” 每次走两步，“慢指针” 每次走一步，当二者相等时，即为一个循环周期。此时，判断是不是因为 1 引起的循环，是的话就是快乐数，否则不是快乐数。
         注意：此题不建议用集合记录每次的计算结果来判断是否进入循环，因为这个集合可能大到无法存储；另外，也不建议使用递归，同理，如果递归层次较深，会直接导致调用栈崩溃。不要因为这个题目给出的整数是 int 型而投机取巧。
         
         判断循环用快慢指针
         
         链接：https://leetcode-cn.com/problems/happy-number/solution/shi-yong-kuai-man-zhi-zhen-si-xiang-zhao-chu-xun-h/
         
         */
        
        func caculateSum(_ n : Int) ->Int {
            var number = n
            var result = 0
            while number > 0 {
                let bitNumber = number % 10
                result += bitNumber * bitNumber
                number = number / 10
            }
            return result
        }
        
        func isHappy(_ n:Int)->Bool {
            var fast = n
            var slow = n
            var first = true
            while first || slow != fast {
                if first {
                    first = false
                }
                slow = caculateSum(slow)
                fast = caculateSum(fast)
                fast = caculateSum(fast)
            }
            return slow == 1
        }
        print("23:\(isHappy(23))")
        print("19:\(isHappy(19))")
        print("2:\(isHappy(2))")
    }
    
    
    
}
