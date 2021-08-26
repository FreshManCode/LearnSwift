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
                //              比目标值小,向前移动
                else if (sumValue < target) {
                    left += 1
                }
                //              比目标值大,向后移动
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
    
}
