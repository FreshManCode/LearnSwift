//
//  SWMaxSubArrayVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/8/4.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWMaxSubArrayVC: SWBaseViewController {
    //6
    let maxSubArray1 = [-2,1,-3,4,-1,2,1,-5,4]
    //-1
    let maxSubArray2 = [-1]
    //0
    let maxSubArray3 = [0]
    
    ///3
    let testWords = "my name is  a b   d h o lll ddd"
    ///0
    let testWords1 = " "
    //5
    let testWords2 = "Hello World"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
    }
    
    
    func p_initDefautData()  {
        title = "最大子序和最后一个单词的长度"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1.最大子序和(自己实现) ",
                                            subTitle: "",
                                            funName: "myMaxSubArray"))
        
        listItemArray.append(SWBookListItem(title: "2.最后一个单词的长度(自己实现) ",
                                            subTitle: "",
                                            funName: "myLastWordLength"))
        listItemArray.append(SWBookListItem(title: "3.最后一个单词的长度(倒序遍历) ",
                                            subTitle: "",
                                            funName: "reversedLastWordLength"))
        
        
        
        tableView.reloadData()
        
    }
    
    // MARK: - 最大子序和
    @objc func myMaxSubArray() {
        /**
         最大子序和
         给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。
         
         //动态规划的实现
         // Kadane算法扫描一次整个数列的所有数值，
         // 在每一个扫描点计算以该点数值为结束点的子数列的最大和（正数和）。
         // 该子数列由两部分组成：以前一个位置为结束点的最大子数列、该位置的数值。
         // 因为该算法用到了“最佳子结构”（以每个位置为终点的最大子数列都是基于其前一位置的最大子数列计算得出,
         // 该算法可看成动态规划的一个例子。
         // 状态转移方程：sum[i] = max{sum[i-1]+a[i],a[i]}
         // 其中(sum[i]记录以a[i]为子序列末端的最大序子列连续和)
         
         https://leetcode-cn.com/problems/maximum-subarray/solution/xiang-xi-jie-du-dong-tai-gui-hua-de-shi-xian-yi-li/
         */
        
    }
    
    func myMaxSubArray(_ nums: [Int]) -> Int {
        if nums.count < 1 {
            return 0
        }
        //   在每一个扫描点计算以该点数值为结束点的子数列的最大和（正数和）。
        var pre = 0
        var maxAnswer = nums[0]
        for item in nums {
            // 以每个位置为终点的最大子数列 都是基于其前一位置的最大子数列计算得出,
            pre = max(pre + item, item)
            maxAnswer = max (maxAnswer,pre)
        }
        return maxAnswer
    }
    
    // MARK: - 最后一个单词的长度
    @objc func myLastWordLength() {
        /**
         最后一个单词的长度
         给你一个字符串 s，由若干单词组成，单词之间用单个或多个连续的空格字符隔开。返回字符串中最后一个单词的长度。如果不存在最后一个单词，请返回 0 。
         
         单词 是指仅由字母组成、不包含任何空格字符的最大子字符串。
         
         
         示例 1：
         
         输入：s = "Hello World"
         输出：5
         示例 2：
         
         输入：s = " "
         输出：0
         
         
         */
        print("result:\(myLengthOfLastWord(testWords))")
        print("result2:\(myLengthOfLastWord(testWords1))")
        print("result3:\(myLengthOfLastWord(testWords2))")
        
    }
    
    func myLengthOfLastWord(_ s: String) -> Int {
        if s.count < 1 {
            return 0
        }
        let result = s.split(separator: " ")
        if result.count < 1 {
            return 0
        }
        guard let myResult = result.last else { return 0 }
        return myResult.count
    }
    
    @objc func reversedLastWordLength() {
        /**
         倒序遍历
         遇到第一个非空字符开始计数
         当计数大于0时，并且遇到空字符，则提前退出循环
         */
        print("re_result:\(reversedLastWordLength(testWords))")
        print("re_result2:\(reversedLastWordLength(testWords1))")
        print("re_result3:\(reversedLastWordLength(testWords2))")
    }
    func reversedLastWordLength(_ s:String)->Int {
        var answer = 0
        for char in s.reversed() {
            //遇到空格判断是否已经有值
            if char == " " {
                if answer > 0 {
                    break;
                } else {
                    continue
                }
            } else {
                answer += 1
            }
        }
        return answer
    }
}
