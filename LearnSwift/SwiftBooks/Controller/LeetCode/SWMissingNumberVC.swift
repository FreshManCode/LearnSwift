//
//  SWMissingNumberVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/9/22.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWMissingNumberVC: SWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
    }
    
    func p_initDefautData()  {
        title = " 丢失的数字"
        view.addSubview(tableView)
        listItemArray.append(SWBookListItem(title: "1.  丢失的数字 ",
                                            subTitle: "",
                                            funName: "myMissingNumber"))
        listItemArray.append(SWBookListItem(title: "1.1  丢失的数字(高斯公式求和)",
                                            subTitle: "",
                                            funName: "missingNumber"))
        
        listItemArray.append(SWBookListItem(title: "2  第一个错误的版本",
                                            subTitle: "",
                                            funName: "myFirstBadVersion"))
        
        listItemArray.append(SWBookListItem(title: "3.  移动零",
                                            subTitle: "",
                                            funName: "myMoveZeros"))
        
        listItemArray.append(SWBookListItem(title: "3.1  移动零(双指针)",
                                            subTitle: "",
                                            funName: "moveZeros"))
        
        listItemArray.append(SWBookListItem(title: "4.  单词规律",
                                            subTitle: "",
                                            funName: "myWordPattern"))
        
        listItemArray.append(SWBookListItem(title: "5.   Nim 游戏",
                                            subTitle: "",
                                            funName: "myCanWinNim"))
        
        listItemArray.append(SWBookListItem(title: "6. 区域和检索 - 数组不可变",
                                            subTitle: "",
                                            funName: "sumRange"))
        
        listItemArray.append(SWBookListItem(title: "7. 3的幂",
                                            subTitle: "",
                                            funName: "isPowerOfThree"))
        
        
        
        
        tableView.reloadData()
    }
    
    
    // MARK: - 1.丢失的数字
    @objc func myMissingNumber()  {
        /**
         给定一个包含 [0, n] 中 n 个数的数组 nums ，找出 [0, n] 这个范围内没有出现在数组中的那个数。
         
         */
        func missingNumber(_ nums: [Int]) -> Int {
            var setIndex = Set <Int>()
            for index in 0...nums.count {
                setIndex.insert(index)
            }
            for item in nums {
                if setIndex.contains(item) {
                    setIndex.remove(item)
                }
            }
            return setIndex.first ?? -1
        }
        
        //      使用hash表进行映射
        func missingNumber2(_ nums: [Int]) -> Int {
            var index = 0
            let set = Set.init(nums)
            while index < set.count {
                if set.contains(index) {
                    index += 1
                } else {
                    break
                }
            }
            return index
        }
        
        let nums1 = [0,1],nums2 = [9,6,4,2,3,5,7,0,1];
        print("nums1:\(missingNumber(nums1))")
        print("nums2:\(missingNumber(nums2))")
        
        func missingNumber3 (_ nums:[Int]) ->Int {
            /**
             我们可以用 高斯求和公式 求出 [0..n][0..n] 的和，减去数组中所有数的和，就得到了缺失的数字。
             */
            let totalSum = nums.count * (nums.count + 1) / 2
            var currentSum = 0
            for item in nums {
                currentSum += item
            }
            return totalSum - currentSum
        }
    }
    
    // MARK: - 2  第一个错误的版本
    @objc func myFirstBadVersion()  {
        /**
         你是产品经理，目前正在带领一个团队开发新的产品。不幸的是，你的产品的最新版本没有通过质量检测。由于每个版本都是基于之前的版本开发的，所以错误的版本之后的所有版本都是错的。
         
         假设你有 n 个版本 [1, 2, ..., n]，你想找出导致之后所有版本出错的第一个错误的版本。
         
         你可以通过调用 bool isBadVersion(version) 接口来判断版本号 version 是否在单元测试中出错。实现一个函数来查找第一个错误的版本。你应该尽量减少对调用 API 的次数。
         */
        func isBadVersion(_ version:Int)->Bool {
            return version > 3
        }
        func firstBadVersion(_ n: Int) -> Int {
            var left = 1
            var right = n
            // 循环直至区间左右端点相同
            while left < right {
                let mid = left + (right - left )/2
                //              错误版本还要继续向下
                if isBadVersion(mid) {
                    //                   答案在区间 [left mid]
                    right = mid
                }
                //              错误版本在上面
                else {
                    //                   答案在区间 [mid+1, right] 中
                    left = mid + 1
                }
            }
            //           此时有 left == right，区间缩为一个点，即为答案
            return left
        }
    }
    
    
    // MARK: - 移动零
    @objc func myMoveZeros()  {
        /**
         给定一个数组 nums，编写一个函数将所有 0 移动到数组的末尾，同时保持非零元素的相对顺序。
         输入: [0,1,0,3,12]
         输出: [1,3,12,0,0]
         */
        func moveZeroes(_ nums: inout [Int]) {
            var zeroNumbers = [Int]()
            var deleteCount = 0
            
            for (index,item) in nums.enumerated() {
                if item == 0 {
                    let zeroNum = nums.remove(at: index - deleteCount)
                    zeroNumbers.append(zeroNum)
                    deleteCount += 1
                }
            }
            nums.insert(contentsOf: zeroNumbers, at: nums.count)
        }
        var inputs1 = [0,1,0,3,12]
        moveZeroes(&inputs1)
        print("inputs1:\(inputs1)")
    }
    
    // MARK: - 移动零(双指针)
    @objc func moveZeros()  {
        /**
         使用双指针，左指针指向当前已经处理好的序列的尾部，右指针指向待处理序列的头部。
         
         右指针不断向右移动，每次右指针指向非零数，则将左右指针对应的数交换，同时左指针右移。
         
         注意到以下性质：
         
         左指针左边均为非零数；
         
         右指针左边直到左指针处均为零。
         
         因此每次交换，都是将左指针的零与右指针的非零数交换，且非零数的相对顺序并未改变。
         
         链接：https://leetcode-cn.com/problems/move-zeroes/solution/yi-dong-ling-by-leetcode-solution/
         */
        func swap(_ nums:inout [Int],_ left:Int,_ right:Int) {
            let tempValue = nums[left]
            nums[left]    = nums[right]
            nums[right]   = tempValue
        }
        
        func moveZeroes(_ nums: inout [Int]) {
            var left = 0,right = 0;
            while right < nums.count {
                if nums[right] != 0 {
                    swap(&nums, left, right)
                    left += 1
                }
                right += 1
            }
        }
        var inputs1 = [0,1,0,3,12]
        moveZeroes(&inputs1)
        print("inputs1:\(inputs1)")
        
    }
    
    // MARK: - 单词规律
    @objc func myWordPattern()  {
        /**
         给定一种规律 pattern 和一个字符串 str ，判断 str 是否遵循相同的规律。
         
         这里的 遵循 指完全匹配，例如， pattern 里的每个字母和字符串 str 中的每个非空单词之间存在着双向连接的对应规律。
         
         示例1:
         
         输入: pattern = "abba", str = "dog cat cat dog"
         输出: true
         
         示例 2:
         
         输入:pattern = "abba", str = "dog cat cat fish"
         输出: false
         
         */
        func wordPattern(_ pattern: String, _ s: String) -> Bool {
            //          hash映射,分别对左右两个str中的char/str 为key,另一个为value,放在一个map中,做相对的对比
            return wordLeftPattern(pattern, s) && wordRightPattern(pattern, s)
        }
        func wordLeftPattern(_ pattern: String, _ s: String) -> Bool {
            let chars = Array.init(pattern)
            var tempStr = ""
            var tempDic = [Character:String]()
            var index = 0
            for item in s {
                if item != " " {
                    tempStr = tempStr + String(item)
                } else {
                    let charDigit = chars[index]
                    //                  字典中是否有该char的key,有对比是否相等,没有则赋值
                    if tempDic[charDigit] != nil {
                        if tempDic[charDigit] != tempStr {
                            return false
                        }
                    } else {
                        tempDic[charDigit] = tempStr
                    }
                    index += 1
                    tempStr = ""
                }
            }
            //          判断两个字符串的count是否相同
            if index != chars.count - 1 {
                return false
            }
            
            let lastChar = chars.last!
            if tempDic[lastChar] != nil {
                return tempDic[lastChar] == tempStr
            }
            return true
        }
        
        func wordRightPattern(_ pattern: String, _ s: String) -> Bool {
            let chars = Array.init(pattern)
            var tempStr = ""
            var tempDic = [String:Character]()
            var index = 0
            for item in s {
                if item != " " {
                    tempStr = tempStr + String(item)
                } else {
                    let charDigit = chars[index]
                    if tempDic[tempStr] != nil {
                        if tempDic[tempStr] != charDigit {
                            return false
                        }
                    } else {
                        tempDic[tempStr] = charDigit
                    }
                    index += 1
                    tempStr = ""
                }
            }
            if index != chars.count - 1 {
                return false
            }
            let lastChar = chars.last!
            if tempDic[tempStr] != nil {
                return tempDic[tempStr] == lastChar
            }
            return true
        }
        
        
        
        
        print("1:\(wordPattern("abba", "dog cat cat dog"))")
        print("2:\(wordPattern("abba", "dog cat cat fish"))")
        
    }
    
    // MARK: - 5. Nim 游戏
    @objc func myCanWinNim()  {
        /**
         你和你的朋友，两个人一起玩 Nim 游戏：
         
         桌子上有一堆石头。
         你们轮流进行自己的回合，你作为先手。
         每一回合，轮到的人拿掉 1 - 3 块石头。
         拿掉最后一块石头的人就是获胜者。
         假设你们每一步都是最优解。请编写一个函数，来判断你是否可以在给定石头数量为 n 的情况下赢得游戏。如果可以赢，返回 true；否则，返回 false 。
         */
        func canWinNim(_ n: Int) -> Bool {
            /**
             分析:如果剩余的只要是4的整数倍,则我们无论怎样取,始终无法获取最后一块石头
             */
            return n % 4 != 0
        }
    }
    
    
    // MARK: - 6.区域和检索 - 数组不可变
    @objc func sumRange()  {
        let nums = [-2, 0, 3, -5, 2, -1]
        func sumRange(_ i: Int, _ j: Int) -> Int {
            var index = 0
            var sum = 0
            while index <= j {
                if index >= i {
                    sum += nums[index]
                }
                index += 1
            }
            return sum
        }
        
        print("0-2:\(sumRange(0, 2))")
        print("2-5:\(sumRange(2, 5))")
        print("0-5:\(sumRange(0, 5))")
        /**
         每次调用 sumRange 时，都遍历 i 到 j 之间的元素，进行累加。该效率比较低
         */
    }
    
    // MARK: - 7. 3的幂
    @objc func isPowerOfThree()  {
        /**
         给定一个整数，写一个函数来判断它是否是 3 的幂次方。如果是，返回 true ；否则，返回 false 。
         
         整数 n 是 3 的幂次方需满足：存在整数 x 使得 n == 3 ^ x
         */
        func isPowerOfThree(_ n: Int) -> Bool {
            /**
             方法一：试除法
             思路与算法

             我们不断地将 n 除以 3，直到 n=1。如果此过程中 n 无法被 3 整除，就说明 n 不是 3 的幂。

             本题中的 n 可以为负数或 0，可以直接提前判断该情况并返回False，也可以进行试除，因为负数或 0 也无法通过多次除以 3 得到 1。
             链接：https://leetcode-cn.com/problems/power-of-three/solution/3de-mi-by-leetcode-solution-hnap/
             */
            var result = n
            while result > 0 &&  result % 3 == 0 {
                result = result / 3
            }
            return result == 1
        }
        
        /**
         方法二：判断是否为最大 33 的幂的约数
         思路与算法

         我们还可以使用一种较为取巧的做法。

         在题目给定的 3232 位有符号整数的范围内，最大的 3 的幂为 3^{19} = 11622614673
        
         我们只需要判断 n 是否是 3^{19}的约数即可。

         与方法一不同的是，这里需要特殊判断 n 是负数或 0 的情况。

         链接：https://leetcode-cn.com/problems/power-of-three/solution/3de-mi-by-leetcode-solution-hnap/
        
         */
        func simpleIsPowerOfThree(_ n: Int) -> Bool {
            return n > 0 && 11622614673 % 3 == 0
        }
    }
    
    
    
    
    
    
    
    
}



///  区域和检索 - 数组不可变 (引入前缀和)
class NumArray {
    var sumsArray = [Int]()
    init(_ nums: [Int]) {
        var sum = 0
        sumsArray.append(sum)
        for num in nums {
            sum += num
            sumsArray.append(sum)
        }
    }
    
    func sumRange(_ left: Int, _ right: Int) -> Int {
        return sumsArray[right + 1] - sumsArray[left]
    }
}

